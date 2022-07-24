#!/bin/sh

prefix=/tmp/bootstrap
mkdir -p $prefix

curl https://raw.githubusercontent.com/gnumber13/vm_configs/main/mount_virtfs.service > $prefix/mount_virtfs.service
curl https://raw.githubusercontent.com/gnumber13/vm_configs/main/10-monitor.conf > $prefix/10-monitor.conf

sudo mkdir /etc/sddm.conf.d
curl https://raw.githubusercontent.com/gnumber13/vm_configs/main/sddm.conf.d/autologin.conf > $prefix/autologin.conf


if [ ! -z "$(pacman --version  2> /dev/null)" ];then
    sudo pacman -S sddm  -y
    sudo systemctl disable display-manager.service
    sudo systemctl enable sddm
fi

if [ ! -z "$(dnf --version  2> /dev/null)" ];then
    sudo dnf install sddm -y
    sudo systemctl disable display-manager.service
    sudo systemctl enable sddm
fi

[ ! -z "$(apt --version  2> /dev/null)" ] && sudo apt install sddm -y 


[ ! -d "$HOME/shared" ] && mkdir -p "$HOME/shared"
sudo cp /tmp/mount_virtfs.service /etc/systemd/system/
sudo systemctl daemon-reload

sudo systemctl enable mount_virtfs.service
sudo systemctl start mount_virtfs.service

[ ! -d "/etc/X11/xorg.conf.d/" ] && mkdir -p /etc/X11/xorg.conf.d/
sudo cp /tmp/10-monitor.conf /etc/X11/xorg.conf.d/
