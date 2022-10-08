
apt-get -y install ethtool
apt-get -y install ntpstat ntpdate ntp
apt-get -y install gkrellm* lshw
apt-get -y install libimage-exiftool-perl zsteg
  apt-get -y install htop iotop iftop lm-sensors audispd-plugins usbguard sysstat hdparm
  apt-get -y install suricata* psad chaosreader ipcalc driftnet arpwatch arpon
#selinux
apt-get -y install setools setools-gui selinux-policy-default selinux-basics 
#av
apt-get -y install clamav yara rkhunter aide chkrootkit acct logwatch tripwire fail2ban
#forensics
apt-get -y install strace gdb dcfldd pngcheck autopsy ddrescue 
#media
apt-get -y install mpv smplayer vlc geeqie gimp sox
#hamradio
apt-get -y install gnuradio rtl-sdr hackrf gqrx-sdr kismet* 
#benchmarking
apt-get -y install boinc-client boinc-manager iozone3 sysbench
#vuln scanners
apt-get -y install openvas* sqlmap nikto wapiti 
#browsers
apt-get -y upgrade chromium firefox w3m lynx
#proxy
apt-get -y install privoxy docker-compose
#math
apt-get -y install sagemath bc libreoffice-calc

#pam
apt-get -y install libpam-tmpdir libpam-usb libpam-cracklib libpam-passwdqc
#apt
apt-get -y install apt-listbugs debian-goodies needrestart debsecan debsums apt-transport-https
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
apt -y install qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils libguestfs-tools genisoimage virtinst libosinfo-bin
apt -y install speedtest-cli
