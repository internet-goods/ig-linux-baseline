#!/bin/bash
bash ./pentoo-emerge.sh
bash ./gentoo-openrc.sh
bash ./gentoo-localtime.sh
bash ./gentoo-NetworkManager.sh
cp ./gentoo-rules-save /var/lib/iptables/rules-save
cp ./issue /etc/issue
#TODO ipv6 version of this

