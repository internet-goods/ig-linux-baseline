#!/bin/bash
bash sysctl-basdeline.sh
bash sshd-baseline.sh
bash cron-baseline.sh
bash modprobe-baseline.sh
#bash apt-baseline.sh
#bash ai-baseline.sh
#bash git-baseline.sh
#bash wget-baseline.sh
bash systemctl-baseline.sh
mount -o remount,hidepid=2 /proc
echo "* hard core 0" > /etc/security/limits.d/ig-baseline.conf
echo "* soft core 0" > /etc/security/limits.d/ig-baseline.conf
sed -i 's/sha512/sha512 rounds=800000/g' /etc/pam.d/common-password
apt -y install sysstat
systemctl enable sysstat
sed -i 's/false/true/g' /etc/default/sysstat
service acct start
cp issue /etc/issue
cp issue /etc/issue.net
apt -y install auditd
cp audit.rules /etc/audit
sed -i 's/no/yes/g' /etc/audit/plugins.d/syslog.conf
/etc/init.d/auditd restart
sed -i 's/22/27/g' /etc/login.defs
echo "SHA_CRYPT_MIN_ROUNDS 800000" >> /etc/login.defs
echo "SHA_CRYPT_MAX_ROUNDS 900000" >> /etc/login.defs
echo "PASS_MIN_DAYS 1" >> /etc/login.defs
echo umask 022 > /etc/profile.d/debian-baseline.sh
echo "set mouse=a" >> /etc/vim/vimrc
