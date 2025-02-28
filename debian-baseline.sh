
debian-auditd.sh
debian-baseline.sh
debian-cron.sh
debian-iptables.sh
debian-limits.sh

debian-modprobe.sh
mount -o remount,hidepid=2 /proc
debian-pam-common-password.sh
debian-profile.sh
#debian-rsyslog.conf.sh
debian-sysctl.conf.sh
debian-sysstat.sh
debian-update-rc.d.sh
issue
kali-sshd_config.sh
apt -y install multimon-ng
apt -y install screen
apt -y install libnl*
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
apt -y install zoneminder
apt -y install pdfgrep
apt -y install v4l-utils
apt -y install wavemon
apt -y install ccze
apt -y install horst
apt -y install hashcat*
apt -y install nvidia-cuda-toolkit
apt-get -y install sendmail alpine
apt-get -y install bettercap
apt-get -y install rng-tools
apt-get -y install mmc-utils
apt-get -y install ethtool
apt-get -y install ntpstat ntpdate ntp
apt-get -y install gkrellm* lshw
apt-get -y install libimage-exiftool-perl zsteg
  apt-get -y install htop iotop iftop lm-sensors audispd-plugins usbguard sysstat hdparm
  apt-get -y install suricata* psad chaosreader ipcalc driftnet arpwatch arpon
#selinux
#apt-get -y install setools setools-gui selinux-policy-default selinux-basics 
#av
#apt-get -y install clamav yara rkhunter aide chkrootkit acct logwatch tripwire fail2ban
#forensics
apt-get -y install strace gdb dcfldd pngcheck autopsy ddrescue 
#media
apt-get -y install mpv smplayer vlc geeqie gimp sox
#hamradio
apt-get -y install gnuradio rtl-sdr hackrf gqrx-sdr kismet* 
#benchmarking
apt-get -y install boinc-client boinc-manager iozone3 sysbench
#vuln scanners

apt-get -y install sqlmap nikto wapiti 
#browsers
apt-get -y upgrade chromium firefox w3m lynx
#proxy
apt-get -y install privoxy docker-compose
#math
apt-get -y install libreoffice-calc
apt-get -y install bc
#pam
apt-get -y install libpam-tmpdir libpam-usb libpam-cracklib libpam-passwdqc
#apt
apt-get -y install apt-listbugs debian-goodies needrestart debsecan apt-transport-https
apt-get -y install debsums
apt-get -y install unattended-upgrades apt-listchanges
#hardening
apt-get -y install tiger
apt-get -y install iptables-persistent
#dedup
apt-get -y install rdfind
apt-get -y install python3-pip
apt-get -y install python3-csvkit
apt-get -y install jq
apt-get -y install lynis
apt -y install sdcc
apt -y install qemu-kvm qemu-system-arm qemu-system-x86 virt-manager
apt -y install speedtest-cli
apt -y install mdadm
apt -y install x11-apps
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null

# 2. Add our repository to your list of repositories
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
  sudo tee -a /etc/apt/sources.list.d/signal-xenial.list

# 3. Update your package database and install signal
sudo apt update && sudo apt install signal-desktop

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
