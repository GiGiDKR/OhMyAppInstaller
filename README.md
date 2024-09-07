# OhMy🅰️ppInstaller

**🅰️n application that installs from a selection software not available through Termux or Debian-Proot package managers.**

This project is adapted from [App-Installer](https://github.com/phoenixbyrd/App-Installer) by [Phoenixbyrd](https://github.com/phoenixbyrd).

Currently the only changes are changing the scripts to download the latest available version and not a defined version.

> [!NOTE]
> This software is integrated into my global project [OhMyTermux](https://github.com/GiGiDKR/OhMyTermux) if XFCE installation is selected.
> 
> By default OhMyAppInstaller shortcut is available on the desktop.

### 🅰️pp install

Run the following command :
```bash
curl -sL https://raw.githubusercontent.com/GiGiDKR/OhMyAppInstaller/main/setup.sh -o setup.sh && chmod +x setup.sh && ./setup.sh
```

### 🅰️bout the app

The main window displays a list of selectable software that can be installed or uninstalled.

The status of each software is displayed.

The installation / uninstallation process is executed in the background and a final message is displayed once the operation is completed.

#### 🛒 Software list
- [Obsidian]()
- [VSCode]()
- [PyCharm]()

### 💻 Version history
- 1.0.0 : Initial software upload 
