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
#disable modules
echo "install dccp /bin/true" >> /etc/modprobe.d/securityonion-baseline.conf
echo "install sctp /bin/true" >> /etc/modprobe.d/securityonion-baseline.conf
echo "install rds /bin/true" >> /etc/modprobe.d/securityonion-baseline.conf
echo "install tipc /bin/true" >> /etc/modprobe.d/securityonion-baseline.conf
#harden login settings
sed -i 's/22/27/g' /etc/login.defs
echo "SHA_CRYPT_MIN_ROUNDS 800000" >> /etc/login.defs
echo "SHA_CRYPT_MAX_ROUNDS 900000" >> /etc/login.defs
echo "PASS_MIN_DAYS 1" >> /etc/login.defs
cp issue /etc/issue
cp issue /etc/issue.net
#harden ssh
echo "AllowTcpForwarding no" >> /etc/ssh/sshd_config.d/securityonion-baseline.conf
echo "ClientAliveCountMax 2" >> /etc/ssh/sshd_config.d/securityonion-baseline.conf
echo "LogLevel VERBOSE" > /etc/ssh/sshd_config.d/securityonion-baseline.conf
echo "MaxAuthTries 3" >> /etc/ssh/sshd_config.d/securityonion-baseline.conf
echo "MaxSessions 2" >> /etc/ssh/sshd_config.d/securityonion-baseline.conf
echo "TCPKeepAlive no" >> /etc/ssh/sshd_config.d/securityonion-baseline.conf
echo "AllowAgentForwarding no" >> /etc/ssh/sshd_config.d/securityonion-baseline.conf
#echo "Port 220" >> /etc/ssh/sshd_config.d/securityonion-baseline.conf
echo "X11Forwarding no" >> /etc/ssh/sshd_config.d/securityonion-baseline.conf
