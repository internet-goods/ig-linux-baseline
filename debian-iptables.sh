apt-get -y install iptables-persistent
#3.6 iptables
iptables -F
iptables -P INPUT DROP
iptables -P OUTPUT DROP
#this is not a forwarding firewall config by design
iptables -P FORWARD DROP
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A INPUT -s 127.0.0.0/8 -j DROP
iptables -A OUTPUT -p tcp -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p udp -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p icmp -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp -m state --state ESTABLISHED -j ACCEPT
iptables -A INPUT -p udp -m state --state ESTABLISHED -j ACCEPT
iptables -A INPUT -p icmp -m state --state ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -m state --state NEW -j ACCEPT
iptables -I OUTPUT -m state --state INVALID -j DROP 
iptables -I INPUT -m state --state INVALID -j DROP 
iptables -I INPUT --fragment -j DROP 
iptables -I INPUT -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP
iptables -I INPUT -p tcp --tcp-flags ALL SYN,FIN,PSH,URG -j DROP
iptables -I INPUT -p tcp --tcp-flags ALL FIN,PSH,URG -j DROP
iptables -I INPUT -p tcp --tcp-flags ALL NONE -j DROP
iptables -I INPUT -p tcp --tcp-flags ALL ALL -j DROP
iptables -I INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j DROP
iptables -I INPUT -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP
iptables -I INPUT -p tcp --tcp-flags FIN,RST FIN,RST -j DROP
iptables -I INPUT -p tcp --tcp-flags ACK,URG URG -j DROP
iptables -I INPUT -p tcp --tcp-flags ACK,PSH PSH -j DROP
iptables -I INPUT -p tcp --tcp-flags ACK,FIN FIN -j DROP
#iptables -I INPUT -p udp -m limit --limit 3/s -j ACCEPT
#iptables -I INPUT -p udp -m pkttype --pkt-type broadcast -j DROP
#iptables -I INPUT -p tcp -m tcp --tcp-flags RST RST -m limit --limit 2/second --limit-burst 2 -j ACCEPT
#iptables -I INPUT -p icmp --icmp-type echo-request -m limit --limit 3/s -m length --length 60:65535 -j ACCEPT
#iptables -I INPUT -p icmp -m icmp --icmp-type timestamp-request -j DROP
#iptables -I INPUT -p icmp -m icmp --icmp-type address-mask-request -j DROP
#iptables -I INPUT -p tcp -m state --state NEW -m limit --limit 2/second --limit-burst 2 -j ACCEPT
#block incoming multicast including mDNS
iptables -I INPUT -s 224.0.0.0/4      -j DROP 
iptables -I INPUT -d 224.0.0.0/4      -j DROP 
#block outgoing multicast mDNS 
intables -I OUTPUT -s 224.0.0.0/4   -j DROP
iptables -I OUTPUT -d 224.0.0.0/4   -j DROP
iptables -I INPUT -s 240.0.0.0/5      -j DROP 
iptables -I INPUT -d 240.0.0.0/5      -j DROP
iptables -I INPUT -d 239.255.255.0/24 -j DROP 
iptables -I INPUT -p tcp -m state --state NEW ! --syn -j DROP
iptables -I INPUT -p udp --destination-port 7 -j DROP
iptables-save > /etc/iptables/rules.v4
systemctl enable iptables
