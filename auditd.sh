cp audit.rules /etc/audit
sed -i 's/no/yes/g' /etc/audit/plugins.d/syslog.conf
/etc/init.d/auditd restart
