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
ipset create ethiopia hash:net
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

sudo ipset create ipsum hash:ip
# Download and add (this requires 'curl')
curl -s https://raw.githubusercontent.com/stamparm/ipsum/master/levels/3.txt | \
grep -v "#" | while read ip; do 
    sudo ipset add ipsum $ip
done

