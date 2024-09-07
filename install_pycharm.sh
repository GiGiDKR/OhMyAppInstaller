#!/bin/bash
varname=$(basename $HOME/../usr/var/lib/proot-distro/installed-rootfs/debian/home/*)

url="https://data.services.jetbrains.com/products/download?code=PCC&platform=linux"

proot-distro login debian --user $varname --shared-tmp -- env DISPLAY=:1.0 wget "$url" -O pycharm-community.tar.gz
proot-distro login debian --user $varname --shared-tmp -- env DISPLAY=:1.0 sudo -S apt install default-jdk -y
proot-distro login debian --user $varname --shared-tmp -- env DISPLAY=:1.0 sudo -S tar xzf pycharm-community.tar.gz
proot-distro login debian --user $varname --shared-tmp -- env DISPLAY=:1.0 sudo -S mv pycharm-community-*/ /opt/pycharm-community
proot-distro login debian --user $varname --shared-tmp -- env DISPLAY=:1.0 sudo -S chmod +x /opt/pycharm-community/bin/pycharm.sh

echo "[Desktop Entry]
Name=PyCharm
Comment=A Python IDE
Exec=proot-distro login debian --user $varname --shared-tmp -- env DISPLAY=:1.0 /opt/pycharm-community/bin/./pycharm.sh
Icon=pycharm
Type=Application
StartupNotify=true
Categories=Development;
Path=
Terminal=false
" > $HOME/Desktop/pycharm.desktop

chmod +x $HOME/Desktop/pycharm.desktop
cp $HOME/Desktop/pycharm.desktop $HOME/../usr/share/applications/pycharm.desktop
