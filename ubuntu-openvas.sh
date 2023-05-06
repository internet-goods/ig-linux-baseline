#https://www.ceos3c.com/security/install-openvas-kali-linux/
apt -y install openvas
gvm-setup
sudo runuser -u _gvm -- greenbone-feed-sync --type SCAP
sudo gvm-start
sudo runuser -u _gvm – gvmd --get-scanners
runuser -u _gvm – gvmd --get-users --verbose
#sudo runuser -u _gvm – gvmd --modify-scanner [scanner id] --value [user id]
#https://forum.greenbone.net/t/external-access-to-gsa-web-interface-ip/1671/4
