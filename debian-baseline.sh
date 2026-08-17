apt-baseline.sh
sshd-baseline.sh
ig-ipset.sh
iptables-baseline.sh
sysctl-baseline.sh
suricata-baseline.sh
systemctl-baseline.sh
modprobe-baseline.sh
cron-baseline.sh
systemd-baseline.sh
echo "DEVICESCAN -a -o on -S on -n standby,q -s (S/../.././02|L/../01/./04) -m root -M exec /usr/libexec/smartmontools/smartd-notify" > /etc/smartd.conf
systemctl restart smartd
ai-baseline.sh
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
echo "SHA_CRYPT_MAX_ROUNDS 900000" >> /etc/login.defs/etc/systemd/journald.conf
echo "PASS_MIN_DAYS 1" >> /etc/login.defs
echo umask 022 > /etc/profile.d/debian-baseline.sh

ig-vulnscan.sh
journalctl --vacuum-size=100M
echo SystemMaxUse=50M >> /etc/systemd/journald.conf
echo Storage=volatile >> /etc/systemd/journald.conf
sed -i 's/^#NTP=.*/NTP=8.8.8.8/' /etc/systemd/timesyncd.conf

