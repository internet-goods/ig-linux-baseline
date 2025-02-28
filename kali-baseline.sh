#!/bin/bash
bash debian-auditd.sh
bash debian-baseline.sh
bash debian-cron.sh
bash debian-iptables.sh
bash limits.sh
bash debian-login.defs.sh
bash debian-modprobe.sh
bash debian-mount.sh
bash debian-pam-common-password.sh
bash debian-profile.sh
bash debian-rc.local.sh
bash debian-rsyslog.conf.sh
bash debian-sysctl.conf.sh
bash debian-sysstat.sh
bash debian-update-rc.d.sh
mount -o remount,hidepid=2 /proc
cp issue /etc/issue
cp issue /etc/issue.net
bash kali-sshd_config.sh
apt-get -y install apktool
apt-get -y install checksec
apt-get -y install hcxtools
apt-get -y install ghidra 
apt-get -y install airgeddon
apt-get -y install btscanner
apt-get -y install eaphammer
apt-get -y install python2-dev libpcap-dev
apt-get -y install hostapd hostapd-wpe
apt -y autoremove 

#purge to pass lynis
dpkg --get-selections | awk '$2=="deinstall" {system("sudo apt-get -y purge "$1)}'
lynis audit system
