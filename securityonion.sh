chmod +x /etc/rc.d/rc.local
echo "iptables -I INPUT -i bond0 -d 255.255.255.255 -s 0.0.0.0 -p udp --dport 67 --sport 68 -j DROP" >> /etc/rc.d/rc.local
dnf -y install epel-release
#monitoring
dnf -y install htop sysstat iotop smartmontools lsof lm_sensors hddtemp mcelog psacct usbutils
dnf -y install bluez rtl-sdr
systemctl enable bluetooth
systemctl start bluetooth

yes|sensors-detect
sensors
systemctl enable smartd
systemctl start smartd
systemctl enable mcelog
systemctl start mcelog

#stuff that uses more cpu maybe dont turn on since SO is unstable
systemctl enable psacct
systemctl start psacct
#client apps
dnf -y install screen alpine lynx ccze 
#mlocate
#hardening
dnf -y install lynis openscap openscap-utils scap-security-guide
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
#disable core dumps with limits
bash limits.sh
#sysctl hardening
echo "dev.tty.ldisc.autoload = 0" > /etc/sysctl.d/securityonion-baseline.conf
echo "fs.protected_fifos = 2" >> /etc/sysctl.d/securityonion-baseline.conf
echo "fs.protected_regular = 2" >> /etc/sysctl.d/securityonion-baseline.conf
echo "fs.suid_dumpable = 0" >> /etc/sysctl.d/securityonion-baseline.conf
echo "kernel.dmesg_restrict = 1" >> /etc/sysctl.d/securityonion-baseline.conf
echo "kernel.kptr_restrict = 1" >> /etc/sysctl.d/securityonion-baseline.conf

echo "kernel.perf_event_paranoid = 3" >> /etc/sysctl.d/securityonion-baseline.conf
echo "kernel.sysrq = 0" >> /etc/sysctl.d/securityonion-baseline.conf
echo "kernel.yama.ptrace_scope=3" >> /etc/sysctl.d/securityonion-baseline.conf

#timedatectl set-timezone America/Chicago
dnf -y install sendmail
systemctl enable sendmail
systemctl start sendmail
#dnf -y install rkhunter
#rkhunter --update
#dnf -y install clamav clamav-freshclam clamd
#freshclam
#dnf -y install aide


#mkdir misp-docker
#cp misp-so-docker-compose.yml misp-docker/docker-compose.yml
#cp misp-env misp-docker/.env
#cd misp-docker
#sudo docker compose up -d

#so tuning for 32g machine
sed -i 's/812m/2048m/g' /opt/so/saltstack/default/salt/redis/defaults.yaml
#elasticsearch
sed -i 's/10753m/14336/g' /opt/so/saltstack/local/pilar/minions/securityonion_standalone.sls
#logstash
sed -i 's/1000m/4000m/g' /opt/so/saltstack/local/pilar/minions/securityonion_standalone.sls 
#2 cores
#sed -i "s/lb_procs: '1'/lb_procs: '2'/g" /opt/so/saltstack/local/pillar/minions/security_onion_standalone.sls
#sed -i "s/threads: '1'/threads: '2'/g" /opt/so/saltstack/local/pillar/minions/security_onion_standalone.sls
so-firewall includehost syslog 192.168.0.0/16
so-firewall includehost fleet 192.168.0.0/16
so-firewall includehost beats_endpoint_ssl 192.168.0.0/16
so-firewall includehost elastic_agent_endpoint 192.168.0.0/16
#harden cron to pass lynis
bash cron.sh

#sometimes you gotta dev in prod
#dnf -y install make m4


#systemctl list-unit-files --state=enabled


oscap info /usr/share/xml/scap/ssg/content/ssg-ol9-ds.xml 
mkdir $(date -I)
cd $(date -I)
 oscap xccdf eval \
 --profile xccdf_org.ssgproject.content_profile_pci-dss \
 --report xccdf_org.ssgproject.content_profile_pci-dss.html \
 /usr/share/xml/scap/ssg/content/ssg-ol9-ds.xml

oscap xccdf eval \
 --profile xccdf_org.ssgproject.content_profile_stig \
 --report xccdf_org.ssgproject.content_profile_stig.html \
 /usr/share/xml/scap/ssg/content/ssg-ol9-ds.xml

oscap xccdf eval --fetch-remote-resources \
--profile xccdf_org.ssgproject.content_profile_standard \
--report xccdf_org.ssgproject.content_profile_standard.html \
/usr/share/xml/scap/ssg/content/ssg-ol9-ds.xml
lynis audit system

#git clone https://github.com/docker/docker-bench-security
#cd docker-bench-security
#sh docker-bench-security.sh
#cd ..
#wget https://rpmfind.net/linux/centos-stream/9-stream/AppStream/x86_64/os/Packages/golang-src-1.22.5-2.el9.noarch.rpm
#wget https://rpmfind.net/linux/centos-stream/9-stream/AppStream/x86_64/os/Packages/golang-race-1.22.5-2.el9.x86_64.rpm
#wget https://rpmfind.net/linux/centos-stream/9-stream/AppStream/x86_64/os/Packages/golang-bin-1.22.5-2.el9.x86_64.rpm
#wget https://rpmfind.net/linux/centos-stream/9-stream/AppStream/x86_64/os/Packages/golang-1.22.5-2.el9.x86_64.rpm
#rpm -Uvh golang-1.22.5-2.el9.x86_64.rpm golang-bin-1.22.5-2.el9.x86_64.rpm golang-race-1.22.5-2.el9.x86_64.rpm golang-src-1.22.5-2.el9.noarch.rpm




#aide --init
#cp /var/lib/aide.db.new.gz /var/lib/aide.db.gz
