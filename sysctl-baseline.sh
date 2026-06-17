echo "fs.suid_dumpable = 0" > /etc/sysctl.conf
echo "net.ipv4.conf.default.accept_source_route = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.accept_redirects = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.secure_redirects = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.secure_redirects = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.log_martians = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.log_martians = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.rp_filter = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.rp_filter = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.send_redirects=0" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.accept_redirects=0" >> /etc/sysctl.conf
echo "net.ipv6.conf.all.accept_ra = 0" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.accept_ra = 0" >> /etc/sysctl.conf
echo "net.ipv6.conf.all.accept_redirect = 0" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.accept_redirect = 0" >> /etc/sysctl.conf
echo "net.ipv6.conf.all.accept_redirects=0" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.accept_redirects=0" >> /etc/sysctl.conf

echo "kernel.core_uses_pid=1" >> /etc/sysctl.conf
echo "kernel.kptr_restrict=2" >> /etc/sysctl.conf
echo "kernel.sysrq=0"  >> /etc/sysctl.conf
echo "kernel.yama.ptrace_scope=3"   >> /etc/sysctl.conf
# Set a specific max sample rate
echo "kernel.perf_event_max_sample_rate = 100000"  >> /etc/sysctl.conf
# Disable the "auto-throttle" mechanism (optional)
echo "kernel.perf_cpu_time_max_percent = 25" >> /etc/sysctl.conf
# Increase the max number of open connections
echo "net.core.somaxconn = 65535"  >> /etc/sysctl.conf
# Increase the number of SYN requests allowed
echo "net.ipv4.tcp_max_syn_backlog = 65535" >> /etc/sysctl.conf
# Increase the maximum amount of option memory for networking
echo "net.core.rmem_max = 16777216" >> /etc/sysctl.conf
echo "net.core.wmem_max = 16777216" >> /etc/sysctl.conf
# Reuse TIME_WAIT sockets
echo "net.ipv4.tcp_tw_reuse = 1" >> /etc/sysctl.conf
# Expand local port range for high-volume delivery
echo "net.ipv4.ip_local_port_range = 1024 65535" >> /etc/sysctl.conf
# Speed up the closing of idle connections
echo "net.ipv4.tcp_fin_timeout = 15" >> /etc/sysctl.conf
# Enable SYN cookie protection
echo "net.ipv4.tcp_syncookies = 1" >> /etc/sysctl.conf
# Disable packet forwarding (unless this is a gateway)
echo "net.ipv4.ip_forward = 0" >> /etc/sysctl.conf
# Prevent IP Spoofing
echo "net.ipv4.conf.all.rp_filter = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.rp_filter = 1" >> /etc/sysctl.conf
