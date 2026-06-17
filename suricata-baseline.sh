#!/bin.bash
#setup suricata
suricata-update list-sources --enabled
suricata-update enable-source et/open
suricata-update list-sources --enabled
suricata-update
suricata --build-info
#todo
#sed suricata.yml linux: [192.168.0.0/16,10.0.0.0/8,172.16.0.0/12]
#sed   windows: []
#set eXT_NET to wget http://ipinfo.io/ip -qO -
#sed - interface: eth0 to wlan0
/etc/init.d/suricata start
/etc/init.d/suricata status
tail /var/log/suricata/suricata.log
#todo logrotrate
