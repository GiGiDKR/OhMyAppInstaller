#!/bin/bash

cat <<'EOF' > "$PREFIX/bin/app-installer"
#!/bin/bash

INSTALLER_DIR="$HOME/.App-Installer"
REPO_URL="https://github.com/GiGIDKR/OhMyAppInstaller.git"
DESKTOP_DIR="$HOME/Desktop"
APP_DESKTOP_FILE="$DESKTOP_DIR/app-installer.desktop"

if [ ! -d "$DESKTOP_DIR" ]; then
    mkdir -p "$DESKTOP_DIR"
    echo "Le répertoire Desktop a été créé."
fi

if [ ! -d "$INSTALLER_DIR" ]; then
    git clone "$REPO_URL" "$INSTALLER_DIR"
    if [ $? -eq 0 ]; then
        echo "Le référentiel a été cloné avec succès."
    else
        echo "Échec du clonage du référentiel."
        exit 1
    fi
else
    echo "Le répertoire existe déjà. Clonage ignoré."
    "$INSTALLER_DIR/app-installer"
fi

if [ ! -f "$APP_DESKTOP_FILE" ]; then
    cat <<EOT > "$APP_DESKTOP_FILE"
[Desktop Entry]
Version=1.0
Type=Application
Name=App Installer
Comment=
Exec=$PREFIX/bin/app-installer
Icon=package-install
Categories=System;
Path=
Terminal=false
StartupNotify=false
EOT
    chmod +x "$APP_DESKTOP_FILE"
fi

chmod +x "$INSTALLER_DIR/app-installer"

EOF
chmod +x "$PREFIX/bin/app-installer"
bash $PREFIX/bin/app-installer

if [ ! -d "$HOME/Desktop" ]; then
    mkdir -p "$HOME/Desktop"
    echo "Le répertoire Desktop a été créé."
fi

if [ ! -f "$HOME/Desktop/app-installer.desktop" ]; then
    cat <<EOT > "$HOME/Desktop/app-installer.desktop"
[Desktop Entry]
Version=1.0
Type=Application
Name=App Installer
Comment=
Exec=$PREFIX/bin/app-installer
Icon=package-install
Categories=System;
Path=
Terminal=false
StartupNotify=false
EOT
    chmod +x "$HOME/Desktop/app-installer.desktop"
fi
