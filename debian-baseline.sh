apt-baseline.sh
sshd-baseline.sh
ig-ipset.sh
debian-iptables.sh
sysctl-baseline.sh
suricata-baseline.sh
systemctl-baseline.sh
modprobe-baseline.sh
cron-baseline.sh
sed -i 's/no/yes/g' /etc/audit/plugins.d/syslog.conf
echo "* hard core 0" > /etc/security/limits.d/ig-baseline.conf
echo "* soft core 0" > /etc/security/limits.d/ig-baseline.conf
#debian-modprobe.sh
mount -o remount,hidepid=2 /proc
#debian-pam-common-password.sh
#debian-profile.sh
#debian-rsyslog.conf.sh
cp issue /etc/issue
cp issue /etc/issue.net
cp audit.rules /etc/audit
sed -i 's/false/true/g' /etc/default/sysstat
sed -i 's/22/27/g' /etc/login.defs
echo "SHA_CRYPT_MIN_ROUNDS 800000" >> /etc/login.defs
echo "SHA_CRYPT_MAX_ROUNDS 900000" >> /etc/login.defs
echo "PASS_MIN_DAYS 1" >> /etc/login.defs
echo umask 022 > /etc/profile.d/debian-baseline.sh

ig-vulnscan.sh
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




