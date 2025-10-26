# Debian

设置区域
```
export PATH=$PATH:/usr/sbin
dpkg-reconfigure tzdata
dpkg-reconfigure locales
```

新建用户
```
sudo useradd -m -G sudo,adm -s /bin/bash []
passwd root
passwd []
```

# PostmarketOS

## TTYescape
```
apk add ttyescape
```
```
sudo nano /etc/conf.d/ttyescape.conf
# FONT="/usr/share/consolefonts/LatGrkCyr-12x22.psfu.gz"
```
TTYescape Service
```
sudo nano /etc/init.d/ttyescape
```
```
#!/sbin/openrc-run

name="TTYescape"
description="TTYescape Service"

depend() {
    after *
}

start() {
    ebegin "Open TTYescape"
    /usr/bin/togglevt.sh
    eend $?
}

stop() {
    ebegin "Close TTYescape"
    /usr/bin/togglevt.sh
    eend $?
}
```
```
sudo chmod +x /etc/init.d/ttyescape
```

## ZRAM
```
sudo nano /etc/conf.d/zram-init
# algo0=lzo-rle
```
