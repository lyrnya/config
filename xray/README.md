# SSL

```
下载
curl https://get.acme.sh | sh -s email=abc@gmail.com

设置命令别名，方便使用（注意自己实际路径）
alias acme.sh=~/.acme.sh/acme.sh

设置自动升级
acme.sh --upgrade --auto-upgrade

测试（自己替换）
acme.sh --issue --server letsencrypt --test -d 域名 -w /home/用户名/domains/域名/public_html --keylength ec-256

设置正式环境
acme.sh --set-default-ca --server letsencrypt

生成 SSL（自己替换）
acme.sh --issue -d 域名 -w /home/用户名/domains/域名/public_html --keylength ec-256 --force

安装 SSL，例如在 /home/用户名/domains/xray/ssl 建好文件夹
acme.sh --installcert -d  域名 --cert-file /home/用户名/domains/xray/ssl/cert.crt --key-file /home/用户名/domains/xray/ssl/cert.key --fullchain-file /home/用户名/domains/xray/ssl/fullchain.crt --ecc

至此，SSL 生成完毕，记录 `.crt` 和 `.key` 文件路径，待会在 Xray 里面配置。
```

[thank](https://forum.naixi.net/thread-389-1-1.html)
