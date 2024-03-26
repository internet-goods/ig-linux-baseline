dnf -y install epel-release
#monitoring
dnf -y install htop sysstat iotop smartmontools lsof ccze
systemctl enable smartd
#client apps
dnf -y install screen alpine lynx
#hardening
dnf -y install lynis openscap openscap-utils scap-security-guide
lynis audit system

