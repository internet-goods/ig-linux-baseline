#inventory wifi with iw into /nsm
#run one time
#sed -i "s/#plugins=keyfile,ifcfg-rh/plugins=keyfile/g" /etc/NetworkManager/NetworkManager.conf
#echo "[keyfile]" >> /etc/NetworkManager/NetworkManager.conf
#echo "unmanaged-devices=type:wifi" >> /etc/NetworkManager/NetworkManager.conf
#service NetworkManager restart

WIFI=$(ls -l  /sys/class/net/*/phy80211/name|awk -F/net/ '{print $2}'|awk -F/ '{print $1}')

echo SCANNING $WIFI
echo ifconfig $WIFI up
ifconfig $WIFI up
mkdir -p /nsm/iw
echo iw dev $WIFI scan
iw phy > /nsm/iw/iwphy-$WIFI-$(date +%Y%m%d%H%M%S).log
iw dev > /nsm/iw/iwdev-$WIFI-$(date +%Y%m%d%H%M%S).log
#if wifi is associated show link
iw dev $WIFI link > /nsm/iw/iwdevlink-$WIFI-$(date +%Y%m%d%H%M%S).log
#https://unix.stackexchange.com/questions/40087/is-there-a-way-to-list-the-connected-devices-on-my-wifi-access-point
iw dev $WIFI station dump > /nsm/iw/iwdevstationdump-$WIFI-$(date +%Y%m%d%H%M%S).log
#if wifi is not associated run passive wifi scan
#eleet oneliner version who knows what wil happen with more than one wifi nic
#iw dev $WIFI scan > /nsm/iw/iwdevscan-$(date +%Y%m%d%H%M%S).log
iw dev $(ls -l  /sys/class/net/*/phy80211/name|awk -F/net/ '{print $2}'|awk -F/ '{print $1}') scan > /nsm/iw/iwdevscan-$(date +%Y%m%d%H%M%S).log
