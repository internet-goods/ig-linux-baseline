apt-get -y install systemd-timesyncd
echo "[Time]" > /etc/systemd/timesyncd.conf
echo "NTP=node40" >> /etc/systemd/timesyncd.conf
systemctl daemon-reload
timedatectl set-ntp off
timedatectl set-ntp on
