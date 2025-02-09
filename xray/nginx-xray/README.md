# Nginx 前置 SNI 分流
[Thanks lxhao61](https://github.com/lxhao61/integrated-examples)

## 安装 Nginx
```
https://nginx.org/en/linux_packages.html
```
## 申请 TLS 证书
```
wget -O -  https://get.acme.sh | sh
.acme.sh/acme.sh --upgrade --auto-upgrade
export CF_Token="example"
.acme.sh/acme.sh --issue --server letsencrypt --dns dns_cf -d 'example.com' -d '*.example.com' --keylength ec-256
.acme.sh/acme.sh --installcert -d 'example.com' --cert-file /home/tls/cert.crt --key-file /home/tls/cert.key --fullchain-file /home/tls/fullchain.crt --ecc
```
## 备注
```
# VLESS Vision REALITY
  reality.domain.com

# VLESS XHTTP TLS
  reality.domain.com
  xhttp.domain.com
```