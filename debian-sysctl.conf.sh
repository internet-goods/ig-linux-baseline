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
