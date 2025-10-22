pname(NetworkManager, systemd-resolved, dnsmasq) -> must_direct
pname(xray) -> must_direct

domain(geosite:category-ads-all) -> block
domain(geosite:category-httpdns-cn) -> block
l4proto(udp) && domain(suffix: googlevideo.com) -> block

domain(suffix: deepseek.com) -> proxy

domain(geosite:category-games@cn) -> direct
domain(geosite:steam@cn) -> direct
domain(suffix: steamserver.net) -> direct

dip(geoip:private) -> direct
dip(geoip:cn) -> direct
domain(geosite:cn) -> direct

fallback: proxy

#domain(suffix: v2raya.org) -> my_group # 相当于 domain(v2raya.org) -> my_group 
#domain(full: dns.google) -> my_group
#domain(keyword: facebook) -> my_group
#domain(regex: '\.goo.*\.com$') -> my_group
#domain(geosite:category-ads) -> block
#domain(geosite:cn)->direct
