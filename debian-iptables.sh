apt-get -y install iptables-persistent
iptables -F
iptables -P INPUT DROP
iptables -P OUTPUT DROP
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
iptables -A INPUT -p tcp --dport 25 -m state --state NEW -j ACCEPT
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
#gemini ipsets
#https://en.wikipedia.org/wiki/List_of_United_States_extradition_treaties
#we are always at war with eurasia
ipset flush
ipset create china hash:net
ipset create russia hash:net
ipset create china hash:net
ipset create russia hash:net
ipset create vietnam hash:net
ipset create indo hash:net
ipset create uae hash:net
ipset create saudi hash:net
ipset create ukraine hash:net
ipset create belarus hash:net
ipset create montenegro hash:net
ipset create cambodia hash:net
ipset create laos hash:net
ipset create vanuatu hash:net
ipset create samoa hash:net
ipset create eritrea hash:net
ipset create cuba hash:net
ipset create venezuela hash:net
curl -s http://www.ipdeny.com/ipblocks/data/countries/cn.zone | while read line; do sudo ipset add china $line; done
curl -s http://www.ipdeny.com/ipblocks/data/countries/ru.zone | while read line; do sudo ipset add russia $line; done
curl -s http://www.ipdeny.com/ipblocks/data/countries/vn.zone | while read line; do sudo ipset add vietnam $line; done
curl -s http://www.ipdeny.com/ipblocks/data/countries/id.zone | while read line; do sudo ipset add indo $line; done
curl -s http://www.ipdeny.com/ipblocks/data/countries/ae.zone | while read line; do sudo ipset add uae $line; done
curl -s http://www.ipdeny.com/ipblocks/data/countries/sa.zone | while read line; do sudo ipset add saudi $line; done
curl -s http://www.ipdeny.com/ipblocks/data/countries/ua.zone | while read line; do sudo ipset add ukraine $line; done
curl -s http://www.ipdeny.com/ipblocks/data/countries/by.zone | while read line; do sudo ipset add belarus $line; done
curl -s http://www.ipdeny.com/ipblocks/data/countries/me.zone | while read line; do sudo ipset add montenegro $line; done
curl -s http://www.ipdeny.com/ipblocks/data/countries/kh.zone | while read line; do sudo ipset add cambodia $line; done
curl -s http://www.ipdeny.com/ipblocks/data/countries/la.zone | while read line; do sudo ipset add laos $line; done
curl -s http://www.ipdeny.com/ipblocks/data/countries/vu.zone | while read line; do sudo ipset add vanuatu $line; done
curl -s http://www.ipdeny.com/ipblocks/data/countries/ws.zone | while read line; do sudo ipset add samoa $line; done
curl -s http://www.ipdeny.com/ipblocks/data/countries/er.zone | while read line; do sudo ipset add eritrea $line; done
curl -s http://www.ipdeny.com/ipblocks/data/countries/et.zone | while read line; do sudo ipset add ethiopia $line; done
curl -s http://www.ipdeny.com/ipblocks/data/countries/cu.zone | while read line; do sudo ipset add cuba $line; done
curl -s http://www.ipdeny.com/ipblocks/data/countries/ve.zone | while read line; do sudo ipset add venezuela $line; done
iptables -I INPUT -m set --match-set china src -j DROP
iptables -I INPUT -m set --match-set russia src -j DROP
iptables -I INPUT -m set --match-set vietnam src -j DROP
iptables -I INPUT -m set --match-set indo src -j DROP
iptables -I INPUT -m set --match-set uae src -j DROP
iptables -I INPUT -m set --match-set saudi src -j DROP
iptables -I INPUT -m set --match-set ukraine src -j DROP
iptables -I INPUT -m set --match-set belarus src -j DROP
iptables -I INPUT -m set --match-set montenegro src -j DROP
iptables -I INPUT -m set --match-set cambodia src -j DROP
iptables -I INPUT -m set --match-set laos src -j DROP
iptables -I INPUT -m set --match-set vanuatu src -j DROP
iptables -I INPUT -m set --match-set samoa src -j DROP
iptables -I INPUT -m set --match-set eritrea src -j DROP
iptables -I INPUT -m set --match-set ethiopia src -j DROP
iptables -I INPUT -m set --match-set cuba src -j DROP
iptables -I INPUT -m set --match-set venezuela src -j DROP

sudo ipset create bad_ips hash:ip
# Download and add (this requires 'curl')
curl -s https://raw.githubusercontent.com/stamparm/ipsum/master/levels/3.txt | \
grep -v "#" | while read ip; do 
    sudo ipset add bad_ips $ip
done
# Apply to firewall
iptables -I INPUT -m set --match-set bad_ips src -j DROP
# Add anyone hitting Telnet (23) to the blacklist
iptables -A INPUT -p tcp --dport 23 -j SET --add-set port_scanners src
# Drop all traffic from anyone in the blacklist
iptables -I INPUT -m set --match-set port_scanners src -j DROP

iptables-save > /etc/iptables/rules.v4
systemctl enable iptables
