#!/bin/bash
cp audit.rules /etc/audit
sed -i 's/no/yes/g' /etc/audit/plugins.d/syslog.conf
/etc/init.d/auditd restart

bash debian-baseline.sh
bash debian-cron.sh
bash debian-iptables.sh
echo "* hard core 0" > /etc/security/limits.d/ig-baseline.conf
echo "* soft core 0" > /etc/security/limits.d/ig-baseline.conf

bash debian-mount.sh
sed -i 's/sha512/sha512 rounds=800000/g' /etc/pam.d/common-password
bash debian-profile.sh
bash debian-rsyslog.conf.sh
bash debian-sysctl.conf.sh
apt -y install sysstat
systemctl enable sysstat
sed -i 's/false/true/g' /etc/default/sysstat
update-rc.d acct enable
update-rc.d ssh enable
service ssh start
service acct start
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

sed -i 's/22/27/g' /etc/login.defs
echo "SHA_CRYPT_MIN_ROUNDS 800000" >> /etc/login.defs
echo "SHA_CRYPT_MAX_ROUNDS 900000" >> /etc/login.defs
echo "PASS_MIN_DAYS 1" >> /etc/login.defs

#disable modules
echo "install cramfs /bin/true" > /etc/modprobe.d/debian-baseline.conf
echo "install freevxfs /bin/true" >> /etc/modprobe.d/debian-baseline.conf
echo "install jffs2 /bin/true" >> /etc/modprobe.d/debian-baseline.conf
echo "install hfs /bin/true" >> /etc/modprobe.d/debian-baseline.conf
echo "install hfsplus /bin/true" >> /etc/modprobe.d/debian-baseline.conf
echo "install squashfs /bin/true" >> /etc/modprobe.d/debian-baseline.conf
echo "install udf /bin/true" >> /etc/modprobe.d/debian-baseline.conf
echo "install vfat /bin/true" >> /etc/modprobe.d/debian-baseline.conf
echo "options ipv6 disable=1" >> /etc/modprobe.d/debian-baseline.conf
echo "install dccp /bin/true" >> /etc/modprobe.d/debian-baseline.conf
echo "install sctp /bin/true" >> /etc/modprobe.d/debian-baseline.conf
echo "install rds /bin/true" >> /etc/modprobe.d/debian-baseline.conf
echo "install tipc /bin/true" >> /etc/modprobe.d/debian-baseline.conf
#echo "-w /sbin/modprobe -p x -k modules" >> /etc/audit/rules.d/debian-baseline.conf
#/etc/modprobe.d/debian-baseline.confsystemctl -w kernel.yama.ptrace_scope=3
echo "install firewire-ohci /bin/true" >>  /etc/modprobe.d/debian-baseline.conf
echo "install firewire-sbp2 /bin/true" >>  /etc/modprobe.d/debian-baseline.conf
echo "install usb-storage /bin/true" >> /etc/modprobe.d/debian-baseline.conf

echo umask 022 > /etc/profile.d/debian-baseline.sh

chmod 600 /etc/crontab
chmod 700 /etc/cron.d
chmod 700 /etc/cron.daily
chmod 700 /etc/cron.hourly
chmod 700 /etc/cron.weekly
chmod 700 /etc/cron.monthly
chmod 600 /etc/cron.deny
