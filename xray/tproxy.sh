#!/bin/bash

#from xray

# 设置策略路由 v4
ip rule add fwmark 1 table 100
ip route add local 0.0.0.0/0 dev lo table 100

# 设置策略路由 v6
ip -6 rule add fwmark 1 table 106
ip -6 route add local ::/0 dev lo table 106

# 代理局域网设备 v4
iptables -t mangle -N XRAY
iptables -t mangle -A XRAY -d 127.0.0.1/32 -j RETURN
iptables -t mangle -A XRAY -d 224.0.0.0/4 -j RETURN
iptables -t mangle -A XRAY -d 255.255.255.255/32 -j RETURN
iptables -t mangle -A XRAY -d 192.168.0.0/16 -p tcp -j RETURN
iptables -t mangle -A XRAY -d 192.168.0.0/16 -p udp ! --dport 53 -j RETURN
iptables -t mangle -A XRAY -j RETURN -m mark --mark 0xff
iptables -t mangle -A XRAY -p udp -j TPROXY --on-ip 127.0.0.1 --on-port 12345 --tproxy-mark 1
iptables -t mangle -A XRAY -p tcp -j TPROXY --on-ip 127.0.0.1 --on-port 12345 --tproxy-mark 1
iptables -t mangle -A PREROUTING -j XRAY

# 代理局域网设备 v6
ip6tables -t mangle -N XRAY6
ip6tables -t mangle -A XRAY6 -d ::1/128 -j RETURN
ip6tables -t mangle -A XRAY6 -d fe80::/10 -j RETURN
ip6tables -t mangle -A XRAY6 -d fd00::/8 -p tcp -j RETURN
ip6tables -t mangle -A XRAY6 -d fd00::/8 -p udp ! --dport 53 -j RETURN
ip6tables -t mangle -A XRAY6 -j RETURN -m mark --mark 0xff
ip6tables -t mangle -A XRAY6 -p udp -j TPROXY --on-ip ::1 --on-port 12345 --tproxy-mark 1
ip6tables -t mangle -A XRAY6 -p tcp -j TPROXY --on-ip ::1 --on-port 12345 --tproxy-mark 1
ip6tables -t mangle -A PREROUTING -j XRAY6

# 代理网关本机 v4
iptables -t mangle -N XRAY_MASK
iptables -t mangle -A XRAY_MASK -d 224.0.0.0/4 -j RETURN
iptables -t mangle -A XRAY_MASK -d 255.255.255.255/32 -j RETURN
iptables -t mangle -A XRAY_MASK -d 192.168.0.0/16 -p tcp -j RETURN
iptables -t mangle -A XRAY_MASK -d 192.168.0.0/16 -p udp ! --dport 53 -j RETURN
iptables -t mangle -A XRAY_MASK -j RETURN -m mark --mark 0xff
iptables -t mangle -A XRAY_MASK -p udp -j MARK --set-mark 1
iptables -t mangle -A XRAY_MASK -p tcp -j MARK --set-mark 1
iptables -t mangle -A OUTPUT -j XRAY_MASK

# 代理网关本机 v6
ip6tables -t mangle -N XRAY6_MASK
ip6tables -t mangle -A XRAY6_MASK -d fe80::/10 -j RETURN
ip6tables -t mangle -A XRAY6_MASK -d fd00::/8 -p tcp -j RETURN
ip6tables -t mangle -A XRAY6_MASK -d fd00::/8 -p udp ! --dport 53 -j RETURN
ip6tables -t mangle -A XRAY6_MASK -j RETURN -m mark --mark 0xff
ip6tables -t mangle -A XRAY6_MASK -p udp -j MARK --set-mark 1
ip6tables -t mangle -A XRAY6_MASK -p tcp -j MARK --set-mark 1
ip6tables -t mangle -A OUTPUT -j XRAY6_MASK

# 新建 DIVERT 规则，避免已有连接的包二次通过 TPROXY，理论上有一定的性能提升 v4
iptables -t mangle -N DIVERT
iptables -t mangle -A DIVERT -j MARK --set-mark 1
iptables -t mangle -A DIVERT -j ACCEPT
iptables -t mangle -I PREROUTING -p tcp -m socket -j DIVERT

# 新建 DIVERT 规则，避免已有连接的包二次通过 TPROXY，理论上有一定的性能提升 v6
ip6tables -t mangle -N DIVERT
ip6tables -t mangle -A DIVERT -j MARK --set-mark 1
ip6tables -t mangle -A DIVERT -j ACCEPT
ip6tables -t mangle -I PREROUTING -p tcp -m socket -j DIVERT