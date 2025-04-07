# 设置区域
```
export PATH=$PATH:/usr/sbin
dpkg-reconfigure tzdata
dpkg-reconfigure locales
```

# 新建用户
```
sudo useradd -m -G sudo,adm -s /bin/bash []
passwd root
passwd []
```