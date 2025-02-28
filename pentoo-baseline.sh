#!/bin/bash
bash ./pentoo-emerge.sh
bash ./gentoo-openrc.sh
bash ./gentoo-localtime.sh
#echo [main] > /etc/NetworkManager/NetworkManager.conf
#echo plugins=keyfile >> /etc/NetworkManager/NetworkManager.conf
#echo hostname-mode=none >> /etc/NetworkManager/NetworkManager.conf
cp ./gentoo-rules-save /var/lib/iptables/rules-save
#TODO ipv6 version of this
cp ./issue /etc/issue
bash ./auditd.sh
cp ig-pentoo-ssh.conf /etc/ssh/sshd_config.d
/etc/init.d/sshd restart
