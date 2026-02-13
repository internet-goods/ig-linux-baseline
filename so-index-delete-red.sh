so-index-list |grep -v green|awk '{print "so-elasticsearch-query " $3 " -XDELETE"}' > so-index-delete-red-$(date-I).sh
