#!/bin/bash
bash ./pentoo-emerge.sh
bash ./gentoo-openrc.sh
bash ./gentoo-localtime.sh

mkdir /etc/NetworkManager/conf.d
#ignore interfaces other than wlan0
cp ./ig-NetworkManager-baseline.conf /etc/NetworkManager/conf.d
cp ./gentoo-rules/save /var/lib/iptables/rules-save
#TODO ipv6 version of this

