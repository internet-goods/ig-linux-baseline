dnf -y install epel-release
#monitoring
dnf -y install htop sysstat iotop smartmontools lsof lm_sensors
yes|sensors-detect
sensors
systemctl enable smartd
#client apps
dnf -y install screen alpine lynx ccze
#hardening
dnf -y install lynis openscap openscap-utils scap-security-guide
lynis audit system

