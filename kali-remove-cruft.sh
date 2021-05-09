#!/bin/bash
apt-get -y remove firmware-b43-installer firmware-b43legacy-installer firmware-bnx2 firmware-bnx2x firmware-cavium firmware-ipw2x00  firmware-ivtv firmware-libertas firmware-netronome firmware-netxen firmware-qcom-media firmware-qlogic firmware-ti-connectivity firmware-zd1211 dahdi-firmware-nonfree mesa-vulkan-drivers mesa-vdpau-drivers mesa-va-drivers 
apt-get -y remove nginx-full nginx-core nginx-common dnsmasq-base
apt-get -y remove network-manager-fortisslvpn network-manager-fortisslvpn-gnome network-manager-l2tp network-manager-openconnect network-manager-openconnect-gnome network-manager-openvpn network-manager-openvpn-gnome network-manager-pptp network-manager-pptp-gnome network-manager-vpnc network-manager-vpnc-gnome
apt-get -y remove tftp atftpd stunnel4 guymager miredo cups-pk-helper curlftpfs doc-debian wpscan
apt-get -y remove  xl2tpd iio-sensor-proxy lrzsz mitmproxy mobile-broadband-provider-info 
apt-get -y --purge remove postgresql postgresql-common king-phisher onesixtyone
userdel postgres
userdel king-phisher
apt-get -y --purge remove avahi-daemon dns2tcp
userdel avahi
#apt-get -y remove php php7.3* apache2*
apt-get -y remove modemmanager
apt-get -y remove redsocks
apt-get -y remove bladerf eject arj axel davtest 
apt-get -y remove automake dbd distro-info-data exploitdb ike-scan iodine lbd ntfs-3g opensc openvpn winexe
apt -y autoremove 
 
#purge packages to pass lynis test
dpkg --get-selections | awk '$2=="deinstall" {system("sudo apt-get -y purge "$1)}'
rm /etc/cron.weekly/tor

