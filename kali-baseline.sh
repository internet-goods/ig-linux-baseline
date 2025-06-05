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

# Open inbound ssh(tcp port 22) connections
#5.2 ssh cfg
chmod og-rwx /etc/ssh/sshd_config
echo "LogLevel VERBOSE" > /etc/ssh/sshd_config.d/baseline.conf
echo "X11Forwarding no" >> /etc/ssh/sshd_config.d/baseline.conf
echo "MaxAuthTries 3" >> /etc/ssh/sshd_config.d/baseline.conf
echo "IgnoreRhosts yes" >> /etc/ssh/sshd_config.d/baseline.conf
echo "HostbasedAuthentication no" >> /etc/ssh/sshd_config.d/baseline.conf
echo "PermitRootLogin no" >> /etc/ssh/sshd_config.d/baseline.conf
echo "PermitEmptyPasswords no" >> /etc/ssh/sshd_config.d/baseline.conf
echo "PermitUserEnvironment no" >> /etc/ssh/sshd_config.d/baseline.conf
echo "Ciphers aes256-ctr,aes192-ctr,aes128-ctr" >> /etc/ssh/sshd_config.d/baseline.conf
echo "MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com" >> /etc/ssh/sshd_config.d/baseline.conf
echo "LoginGraceTime 60" >> /etc/ssh/sshd_config.d/baseline.conf
echo "AllowTcpForwarding no" >> /etc/ssh/sshd_config.d/baseline.conf
echo "ClientAliveCountMax 2" >> /etc/ssh/sshd_config.d/baseline.conf
echo "Compression no"  >> /etc/ssh/sshd_config.d/baseline.conf
echo "MaxAuthTries 4" >> /etc/ssh/sshd_config.d/baseline.conf
echo "MaxSessions 2" >> /etc/ssh/sshd_config.d/baseline.conf
echo "TCPKeepAlive no" >> /etc/ssh/sshd_config.d/baseline.conf
echo "AllowAgentForwarding no" >> /etc/ssh/sshd_config.d/baseline.conf
echo "Port 220" >> /etc/ssh/sshd_config.d/baseline.conf
service sshd reload
update-rc.d ssh enable
service ssh start


apt-get -y install apktool
apt-get -y install checksec
apt-get -y install hcxtools
apt-get -y install ghidra 
apt-get -y install airgeddon
apt-get -y install btscanner
apt-get -y install eaphammer
apt-get -y install python2-dev libpcap-dev
apt-get -y install hostapd hostapd-wpe
apt-get -y install python3-launchpadlib
apt-add-repository -y ppa:team-xbmc/ppa
apt -y install kodi
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
#https://www.kali.org/docs/general-use/install-nvidia-drivers-on-kali-linux/
apt install -y linux-headers-amd64
apt install -y nvidia-driver nvidia-cuda-toolkit
dpkg --add-architecture i386
apt update
apt install steam-installer
apt-get upgrade steam -f
apt -y install nvidia-driver-libs:i386
