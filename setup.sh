#!/bin/bash

# PROBABLY WORKS ONLY ON XFCE

# Remove libreoffice and useless packages (libre can break things when upgrading to testing)
sudo apt update
sudo apt purge "libreoffice*" "fcitx*" khmerconverter xterm debian-reference-common "mlterm*" xiterm+thai goldendict quodlibet anthy "mozc-*" quodlibet -y
sudo apt autopurge -y

# Upgrade to Testing
echo -e "# Debian Testing (for newer packages)\ndeb https://deb.debian.org/debian/ testing main contrib non-free\ndeb-src https://deb.debian.org/debian/ testing main contrib non-free\n\n# Security updates for Testing\ndeb http://security.debian.org testing-security main contrib non-free\ndeb-src http://security.debian.org testing-security main contrib non-free" | sudo tee /etc/apt/sources.list
sudo apt update
sudo apt full-upgrade -y

# Change grub theme and background
wget --content-disposition https://codeload.github.com/vinceliuice/grub2-themes/tar.gz/2019-10-28
tar -xf grub2-themes-2019-10-28.tar.gz
rm grub2-themes-2019-10-28.tar.gz
cd grub2-themes-2019-10-28
sudo ./install.sh --stylish
cd ..
rm -r grub2-themes-2019-10-28
sudo apt install -y imagemagick
cd /usr/share/images
sudo convert -size 1920x1080 xc:#212121 dark_1920x1080.png
sudo update-alternatives --install /usr/share/images/desktop-base/desktop-grub.png desktop-grub /usr/share/images/dark_1920x1080.png 107
sudo update-grub
sudo apt purge -y imagemagick
sudo apt autopurge -y

# Install Adapta theme and Paper icons
sudo apt install -y adapta-gtk-theme
sudo apt install -y devscripts build-essential software-properties-common
sudo touch /etc/apt/sources.list.d/snwh-ubuntu-ppa-bionic.list
echo "deb-src http://ppa.launchpad.net/snwh/ppa/ubuntu bionic main" | sudo tee /etc/apt/sources.list.d/snwh-ubuntu-ppa-bionic.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D320D0C30B02E64C5B2BB2743766223989993A70
sudo apt update
apt source --build paper-icon-theme
sudo apt install ./paper-icon-theme*.deb
rm -r paper-icon-theme*
