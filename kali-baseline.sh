#!/bin/bash
bash debian-auditd.sh
bash debian-baseline.sh
bash debian-cron.sh
bash debian-iptables.sh
bash debian-limits.sh
bash debian-login.defs.sh
bash debian-modprobe.sh
bash debian-mount.sh
bash debian-pam-common-password.sh
bash debian-profile.sh
bash debian-rc.local.sh
bash debian-rsyslog.conf.sh
bash debian-sysctl.conf.sh
bash debian-sysstat.sh
bash debian-update-rc.d.sh
cp issue /etc/issue
cp issue /etc/issue.net
bash kali-sshd_config.sh
