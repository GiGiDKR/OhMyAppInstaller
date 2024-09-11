#!/bin/bash

#This script installs aarch64 appimages into debian proot /opt directory and creates a desktop and menu launcher

# Default values to edit
#Enter URL to appimage
url="https://downloader.cursor.sh/linux/appImage/x64"
#Enter name of app
appname="Cursor"
#Enter path to icon or system icon name
icon_path="cursor"
#Enter Categories for .desktop
category="Development"
#Enter any dependencies
depends="zlib1g-dev"

#Do not edit below here unless required
# Process command line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --install)
            install=true
            shift
            ;;
        --uninstall)
            uninstall=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

if [ "$install" = true ]; then
    download="wget $url"
    extract="${url##*/} --appimage-extract"
    dir="/opt/$appname"
    install="prun sudo apt install -y "

    varname=$(basename $HOME/../usr/var/lib/proot-distro/installed-rootfs/debian/home/*)
    prun="proot-distro login debian --user $varname --shared-tmp -- env DISPLAY=:1.0 $@"

    $install $depends
    $prun $download
    $prun chmod +x ${url##*/}
    $prun ./$extract
    $prun rm ${url##*/}
    $prun mv squashfs-root $dir

    installed_dir="$HOME/../usr/var/lib/proot-distro/installed-rootfs/debian/$dir"
    desktop_file="$HOME/Desktop/$appname.desktop"
    binary=$(find "$installed_dir" -type f -executable -print -quit)

    #If binary is different, specify it here after $installed_dir/ and use $alt_binary instead of $binary
    alt_binary="$installed_dir/cursor"

    #If binary is sandboxed use $sandboxed at end of Exec command
    sandboxed="--no-sandbox %U"

#NOTE: Do not remove prun from Exec command
cat > "$desktop_file" <<EOL
[Desktop Entry]
Name=$appname
Exec=prun $alt_binary $sandboxed
Terminal=false
Type=Application
Icon=$icon_path
StartupWMClass=Cursor
Comment=Cursor is an AI-first coding environment.
MimeType=x-scheme-handler/cursor;
Categories=$category;

EOL

chmod +x "$desktop_file"
cp "$desktop_file" $HOME/../usr/share/applications
echo "Installation completed."

elif [ "$uninstall" = true ]; then
    echo "Uninstalling..."
    dir="/opt/$appname"
    installed_dir="$HOME/../usr/var/lib/proot-distro/installed-rootfs/debian/$dir"
    rm -rf "$installed_dir"
    desktop_file="$HOME/Desktop/$appname.desktop"
    rm "$desktop_file"
    rm "$HOME/../usr/share/applications/$appname.desktop"

    echo "Uninstallation completed."
else
    echo "No valid option provided. Use --install or --uninstall."
    exit 1
fi
