# Open inbound ssh(tcp port 22) connections
#5.2 ssh cfg
chmod og-rwx /etc/ssh/sshd_config
echo "LogLevel VERBOSE" > /etc/ssh/sshd_config.d/baseline.conf
echo "X11Forwarding no" >> /etc/ssh/sshd_config.d/baseline.conf
echo "MaxAuthTries 3" >> /etc/ssh/sshd_config.d/baseline.conf
echo "IgnoreRhosts yes" >> /etc/ssh/sshd_config.d/baseline.conf
echo "HostbasedAuthentication no" >> /etc/ssh/sshd_config.d/baseline.conf
echo "PermitRootLogin no" >> /etc/ssh/sshd_config.d/baseline.conf
echo "PermitEmptyPasswords no" >> /etc/ssh/sshd_config.d/baseline.conf
echo "PermitUserEnvironment no" >> /etc/ssh/sshd_config.d/baseline.conf
echo "Ciphers aes256-ctr,aes192-ctr,aes128-ctr" >> /etc/ssh/sshd_config.d/baseline.conf
echo "MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com" >> /etc/ssh/sshd_config.d/baseline.conf
echo "LoginGraceTime 60" >> /etc/ssh/sshd_config.d/baseline.conf
echo "AllowTcpForwarding no" >> /etc/ssh/sshd_config.d/baseline.conf
echo "ClientAliveCountMax 2" >> /etc/ssh/sshd_config.d/baseline.conf
echo "Compression no"  >> /etc/ssh/sshd_config.d/baseline.conf
echo "MaxAuthTries 4" >> /etc/ssh/sshd_config.d/baseline.conf
echo "MaxSessions 2" >> /etc/ssh/sshd_config.d/baseline.conf
echo "TCPKeepAlive no" >> /etc/ssh/sshd_config.d/baseline.conf
echo "AllowAgentForwarding no" >> /etc/ssh/sshd_config.d/baseline.conf
echo "Port 220" >> /etc/ssh/sshd_config.d/baseline.conf
service sshd reload
update-rc.d ssh enable
service ssh start
