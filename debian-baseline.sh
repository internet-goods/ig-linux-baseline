apt-baseline.sh
sed -i 's/no/yes/g' /etc/audit/plugins.d/syslog.conf
echo "* hard core 0" > /etc/security/limits.d/ig-baseline.conf
echo "* soft core 0" > /etc/security/limits.d/ig-baseline.conf
#debian-modprobe.sh
mount -o remount,hidepid=2 /proc
#debian-pam-common-password.sh
#debian-profile.sh
#debian-rsyslog.conf.sh
debian-sysctl.conf.sh
cp issue /etc/issue
cp issue /etc/issue.net
# Open inbound ssh(tcp port 22) connections
#5.2 ssh cfg
chmod og-rwx /etc/ssh/sshd_config
echo "Banner /etc/issue.net" > /etc/ssh/sshd_config.d/baseline.conf
echo "LogLevel VERBOSE" >> /etc/ssh/sshd_config.d/baseline.conf
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
#echo "Port 220" >> /etc/ssh/sshd_config.d/baseline.conf
cp audit.rules /etc/audit
sed -i 's/false/true/g' /etc/default/sysstat
debian-iptables.sh
sed -i 's/22/27/g' /etc/login.defs
echo "SHA_CRYPT_MIN_ROUNDS 800000" >> /etc/login.defs
echo "SHA_CRYPT_MAX_ROUNDS 900000" >> /etc/login.defs
echo "PASS_MIN_DAYS 1" >> /etc/login.defs
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
echo "install sctp /bin/true" >> /etc/modprobe.d/debian-bapt -y install libnl*aseline.conf
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

#wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
#cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null

# 2. Add our repository to your list of repositories
#echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
#  sudo tee -a /etc/apt/sources.list.d/signal-xenial.list

# 3. Update your package database and install signal
#sudo apt update && sudo apt install signal-desktop


#suricata* psad chaosreader ipcalc driftnet arpwatch arpon
#selinux
#apt-get -y install setools setools-gui selinux-policy-default selinux-basics 



systemctl-baseline.sh
