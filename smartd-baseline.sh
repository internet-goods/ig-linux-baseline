echo "DEVICESCAN -a -o on -S on -n standby,q -s (S/../.././02|L/../01/./04) -m root -M exec /usr/libexec/smartmontools/smartd-notify" /etc/smartd.conf
systemctl restart smartd
