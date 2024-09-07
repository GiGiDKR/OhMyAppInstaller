#!/bin/bash

varname=$(basename $HOME/../usr/var/lib/proot-distro/installed-rootfs/debian/home/*)

latest_release_url=$(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | grep "browser_download_url.*arm64.AppImage" | cut -d : -f 2,3 | tr -d \")

# Install Obsidian
proot-distro login --user $varname debian --shared-tmp -- env DISPLAY=:1.0 sudo -S apt install zlib1g-dev -y
proot-distro login --user $varname debian --shared-tmp -- env DISPLAY=:1.0 wget $latest_release_url -O Obsidian-latest-arm64.AppImage
proot-distro login --user $varname debian --shared-tmp -- env DISPLAY=:1.0 chmod +x Obsidian-latest-arm64.AppImage
proot-distro login --user $varname debian --shared-tmp -- env DISPLAY=:1.0 ./Obsidian-latest-arm64.AppImage --appimage-extract
proot-distro login --user $varname debian --shared-tmp -- env DISPLAY=:1.0 mv squashfs-root /opt/Obsidian
proot-distro login --user $varname debian --shared-tmp -- env DISPLAY=:1.0 rm Obsidian-latest-arm64.AppImage

# Create desktop launcher
echo "[Desktop Entry]
Version=1.0
Name=Obsidian
Exec=proot-distro login debian --user $varname --shared-tmp -- env DISPLAY=:1.0 GALLIUM_DRIVER=virpipe /opt/Obsidian/./obsidian --no-sandbox
StartupNotify=true
Terminal=false
Icon=obsidian
Type=Application
Categories=Office;
" > $HOME/Desktop/obsidian.desktop

chmod +x $HOME/Desktop/obsidian.desktop
cp $HOME/Desktop/obsidian.desktop $HOME/../usr/share/applications/obsidian.desktop