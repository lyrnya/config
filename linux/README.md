Font
```
pacman -S ttf-nerd-fonts-symbols
curl -O https://raw.githubusercontent.com/lyrnya/config/refs/heads/main/linux/fonts.conf
mv fonts.conf ~/.config/fontconfig/fonts.conf
```
NBFC
```
yay -S nbfc-linux
cd /usr/share/nbfc/configs
curl -O https://raw.githubusercontent.com/lyrnya/config/refs/heads/main/linux/Laptop.json
nbfc config -s 'Laptop'
systemctl enable --now nbfc_service.service
```  
