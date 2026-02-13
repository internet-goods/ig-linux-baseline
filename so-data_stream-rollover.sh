so-elasticsearch-query _data_stream|jq |grep name | grep -v index_ | grep -v @timestamp |awk -F\" '{print "so-elasticsearch-query -X POST "$4"/_rollover"}' > so-data_stream-rollover-$(date -I).sh
