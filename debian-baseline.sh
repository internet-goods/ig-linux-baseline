cp audit.rules /etc/audit
sed -i 's/no/yes/g' /etc/audit/plugins.d/syslog.conf
/etc/init.d/auditd restart
debian-iptables.sh
echo "* hard core 0" > /etc/security/limits.d/ig-baseline.conf
echo "* soft core 0" > /etc/security/limits.d/ig-baseline.conf

debian-modprobe.sh
mount -o remount,hidepid=2 /proc
debian-pam-common-password.sh
debian-profile.shinxi
#debian-rsyslog.conf.sh
debian-sysctl.conf.sh
apt -y install sysstat
systemctl enable sysstat
sed -i 's/false/true/g' /etc/default/sysstat

update-rc.d acct enable
update-rc.d ssh enable
service ssh start
service acct start
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
echo "Port 220" >> /etc/ssh/sshd_config.d/baseline.conf
service sshd reload
update-rc.d ssh enable
service ssh start

apt -y install apt-show-versions
apt -y install screen
apt-get -y install  alpine
apt-get -y install htop iotop iftop lm-sensors audispd-plugins usbguard sysstat hdparm
apt-get -y install bc
#pam
apt-get -y install libpam-tmpdir libpam-usb 
apt-get -y install libpam-cracklib
apt-get -y install libpam-passwdqc
#apt
apt-get -y install apt-listbugs debian-goodies needrestart debsecan apt-transport-https
apt-get -y install debsums
apt-get -y install unattended-upgrades apt-listchanges
apt-get -y install iptables-persistent
#dedup
apt-get -y install rdfind
apt-get -y install python3-pip
apt-get -y install python3-csvkit
apt-get -y install jq
apt-get -y install lynis

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
# Second part: conditional
if [ "$1" == "-full" ]; then
    echo "true"
#optionals
#benchmarking
apt-get -y install boinc-client boinc-manager iozone3 sysbench
#browsers
apt-get -y upgrade chromium firefox w3m lynx
apt-get -y install tiger
apt-get -y install libreoffice-calc
apt -y install sdcc
apt -y install qemu-kvm qemu-system-arm qemu-system-x86 virt-manager
apt -y install speedtest-cli
apt -y install mdadm


apt -y install x11-apps inxi
#media
apt-get -y install mpv smplayer vlc geeqie gimp sox
#hamradio
apt-get -y install gnuradio rtl-sdr hackrf gqrx-sdr kismet* 

wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null

# 2. Add our repository to your list of repositories
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
  sudo tee -a /etc/apt/sources.list.d/signal-xenial.list

# 3. Update your package database and install signal
sudo apt update && sudo apt install signal-desktop
#proxy
apt-get -y install privoxy docker-compose
#vuln scanners

apt-get -y install sqlmap nikto wapiti 
 apt-get -y install suricata* psad chaosreader ipcalc driftnet arpwatch arpon
#selinux
#apt-get -y install setools setools-gui selinux-policy-default selinux-basics 
#av
#apt-get -y install clamav yara rkhunter aide chkrootkit acct logwatch tripwire fail2ban
#forensics
apt-get -y install strace gdb dcfldd pngcheck autopsy ddrescue 

apt -y install libpcre3-dev
apt -y install libnm-dev
apt -y install libnl-3-dev
apt -y install libsensors-dev
apt -y install libusb-1.0-0-dev
apt -y install protobuf-compiler
apt -y install libwebsockets-dev
apt -y install libprotobuf-c-dev
apt -y install libprotobuf-dev
apt -y install libssl-dev
apt -y install libsqlite3-dev
apt -y install kismet
apt -y install pdfgrep
apt -y install v4l-utils
apt -y install wavemon
apt -y install ccze
apt -y install horst
apt -y install hashcat*
apt -y install nvidia-cuda-toolkit
apt -y install libnl*
apt-get -y install bettercap
apt-get -y install rng-tools
apt-get -y install mmc-utils
apt-get -y install ethtool
apt-get -y install ntpstat ntpdate ntp
apt-get -y install gkrellm* lshw
apt-get -y install libimage-exiftool-perl zsteg
apt -y install multimon-ng
fi
