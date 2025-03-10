Nginx 前置 SNI 分流
[Thanks lxhao61](https://github.com/lxhao61/integrated-examples)

```
wget -O -  https://get.acme.sh | sh
.acme.sh/acme.sh --upgrade --auto-upgrade
export CF_Token="CF_Token"
.acme.sh/acme.sh --issue --server letsencrypt --dns dns_cf -d 'example.com' -d '*.example.com' --keylength ec-256
mkdir ~/tls/
.acme.sh/acme.sh --installcert -d 'example.com' --cert-file ~/tls/cert.crt --key-file ~/tls/cert.key --fullchain-file ~/tls/fullchain.crt --ecc
```

```
# VLESS Vision REALITY
  reality.example.com

# VLESS XHTTP TLS
  xhttp.example.com
```