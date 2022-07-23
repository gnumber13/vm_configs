#!/bin/sh

[ ! -d "$HOME/shared" ] && mkdir -p "$HOME/shared"
sudo cp mount_virtfs.service /etc/systemd/system/
sudo systemctl daemon-reload

sudo systemctl enable mount_virtfs.service
sudo systemctl start mount_virtfs.service

[ ! -d "/etc/X11/xorg.conf.d/" ] && mkdir -p /etc/X11/xorg.conf.d/
sudo cp 10-monitor.conf /etc/X11/xorg.conf.d/

