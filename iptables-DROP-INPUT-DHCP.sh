#broadcasts dhcp can be noisy, dont let it through to the logging rules, drop silently
iptables -A INPUT -p udp -s 0.0.0.0 -d 255.255.255.255 --sport 68 --dport 67 -j DROP
