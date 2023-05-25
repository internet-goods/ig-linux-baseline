#!/bin/bash
 
iptables -F
iptables -X
iptables -Z
 
iptables -P INPUT DROP
#iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
 
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -d 127.0.0.0/8 ! -i lo -j REJECT --reject-with icmp-port-unreachable


iptables -N SCAN_DROP
iptables -A SCAN_DROP -m limit --limit 2/min -j LOG --log-prefix "INPUT:SCANDROP: " --log-level 6
iptables -A SCAN_DROP -j DROP

#check for suspicous packets
iptables -A INPUT -p tcp -m state --state NEW -m tcp ! --tcp-flags FIN,SYN,RST,ACK SYN -j SCAN_DROP
iptables -A INPUT -p tcp -m tcp --tcp-flags FIN,ACK FIN -j SCAN_DROP
iptables -A INPUT -p tcp -m tcp --tcp-flags PSH,ACK PSH -j SCAN_DROP
iptables -A INPUT -p tcp -m tcp --tcp-flags ACK,URG URG -j SCAN_DROP
iptables -A INPUT -p tcp -m tcp --tcp-flags FIN,RST FIN,RST -j SCAN_DROP
iptables -A INPUT -p tcp -m tcp --tcp-flags FIN,SYN FIN,SYN -j SCAN_DROP
iptables -A INPUT -p tcp -m tcp --tcp-flags SYN,RST SYN,RST -j SCAN_DROP
iptables -A INPUT -p tcp -m tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG FIN,SYN,RST,PSH,ACK,URG -j SCAN_DROP
iptables -A INPUT -p tcp -m tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG NONE -j SCAN_DROP
iptables -A INPUT -p tcp -m tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG FIN,PSH,URG -j SCAN_DROP
iptables -A INPUT -p tcp -m tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG FIN,SYN,PSH,URG -j SCAN_DROP
iptables -A INPUT -p tcp -m tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG FIN,SYN,RST,ACK,URG -j SCAN_DROP
iptables -A INPUT -f -j SCAN_DROP
iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT
/etc/init.d/iptables save
rc-service iptables start 
rc-update add iptables boot
