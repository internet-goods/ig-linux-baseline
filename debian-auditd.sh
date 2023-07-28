echo "-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time-change" > /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time-change" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-a always,exit -F arch=b64 -S clock_settime -k time-change" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-a always,exit -F arch=b32 -S clock_settime -k time-change" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-w /etc/localtime -p wa -k time-change" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-w /etc/group -p wa -k identity" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-w /etc/passwd -p wa -k identity" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-w /etc/gshadow -p wa -k identity" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-w /etc/shadow -p wa -k identity" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-w /etc/security/opasswd -p wa -k identity" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-a always,exit -F arch=b32 -S sethostname -S setdomainname -k system-locale">> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-w /etc/issue -p wa -k system-locale">> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-w /etc/issue.net -p wa -k system-locale">> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-w /etc/hosts -p wa -k system-locale">> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-w /etc/sysconfig/network -p wa -k system-locale">> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-w /etc/selinux/ -p wa -k MAC-policy">> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-w /var/log/lastlog -p wa -k logins" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-w /var/run/faillock/ -p wa -k logins">> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-w /var/run/utmp -p wa -k session" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-w /var/log/wtmp -p wa -k session" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-w /var/log/btmp -p wa -k session" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-a always,exit -F arch=b32 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-a always,exit -F arch=b64 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295 -k perm_mod" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-a always,exit -F arch=b32 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295 -k perm_mod" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access">> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access" >> /etc/audit/rules.d/ig-auditd-baseline.conf  
echo "-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=4294967295 -k mounts" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=4294967295 -k mounts"  >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-a always,exit -F arch=b32 -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-w /etc/sudoers -p wa -k scope" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-w /etc/sudoers.d -p wa -k scope" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-w /var/log/sudo.log -p wa -k actions" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-w /sbin/insmod -p x -k modules" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-w /sbin/rmmod -p x -k modules" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-w /sbin/modprobe -p x -k modules" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-a always,exit arch=b64 -S init_module -S delete_module -k modules" >> /etc/audit/rules.d/ig-auditd-baseline.conf
echo "-b 8192" >> /etc/audit/rules.d/ig-auditd-baseline.conf


sed -i 's/no/yes/g' /etc/audit/plugins.d/syslog.conf
update-rc.d auditd enable
service auditd start
/etc/init.d/auditd start
rc-update enable auditd
