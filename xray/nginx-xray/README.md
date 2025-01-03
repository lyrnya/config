Nginx前置 SNI分流
[Thanks lxhao61](https://github.com/lxhao61/integrated-examples)

编译Nginx
```
# v1.26.2
./configure --prefix=/usr/local/nginx --with-http_ssl_module --with-http_v2_module --with-http_v3_module --with-stream --with-stream_ssl_module --with-http_realip_module --with-stream_ssl_preread_module

/etc/systemd/system/nginx.service

[Unit]
Description=The NGINX HTTP and reverse proxy server
After=syslog.target network-online.target remote-fs.target nss-lookup.target
After=xray.service

[Service]
Type=forking
ExecStartPre=/usr/local/nginx/sbin/nginx -t
ExecStart=/usr/local/nginx/sbin/nginx
ExecReload=/usr/local/nginx/sbin/nginx -s reload
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target
```
申请SSL证书
```
安装 acme.sh
wget -O -  https://get.acme.sh | sh
acme.sh --upgrade --auto-upgrade
acme.sh --set-default-ca --server letsencrypt
```
```
# 测试证书申请
acme.sh --issue --server letsencrypt -d example.com -d *.example.com --keylength ec-256 --test

# 正式证书申请
acme.sh --issue --server letsencrypt -d example.com -d *.example.com --keylength ec-256 --force

# 证书安装
acme.sh --installcert -d example.com --cert-file /path/cert.crt --key-file /path/cert.key --fullchain-file /path/fullchain.crt --ecc
```
```
# Cloudflare DNS 方式
export CF_Token="xxx"
export CF_Zone_ID="xxx"
export CF_Account_ID="xxx"

# 测试证书申请
acme.sh --issue --server letsencrypt --dns dns_cf -d example.com -d *.example.com --keylength ec-256 --test

# 正式证书申请
acme.sh --issue --server letsencrypt --dns dns_cf -d example.com -d *.example.com --keylength ec-256 --force

# 证书安装
acme.sh --installcert -d example.com --cert-file /path/cert.crt --key-file /path/cert.key --fullchain-file /path/fullchain.crt --ecc
```
VLESS+XTLS-Vision+REALITY
```
reality.domain.com
```
VLESS+XHTTP+REALITY
```
reality.domain.com/xhttp
```
VLESS+XHTTP+TLS
```
reality.domain.com/xhttp or tls.domain.com/xhttp
```