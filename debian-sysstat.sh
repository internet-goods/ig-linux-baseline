apt-get -y install sysstat
systemctl enable sysstat
sed -i 's/false/true/g' /etc/default/sysstat

