#!/bin/bash
#bash ./gentoo-openrc.sh
rc-service sshd start
rc-update add sshd
rc-service iptables start
rc-update add iptables 
rc-service ip6tables start
rc-update add ip6tables
rc-service smartd start
rc-update add smartd
rc-service smartd start
rc-update add sendmail
rc-service haveged start
rc-update add haveged
rc-service rngd start
rc-update add rngd
rc-update add thermald
rc-service thermald start
rc-update add lm_sensors
rc-service lm_sensors start
rc-update add sensord
rc-service sensord start
rc-update add mdraid boot
rc-service privoxy start
rc-update add privoxy
rc-service auditd start
rc-update-add auditd
rc-update -v show
rc-status
bash ./gentoo-localtime.sh
#echo [main] > /etc/NetworkManager/NetworkManager.conf
#echo plugins=keyfile >> /etc/NetworkManager/NetworkManager.conf
#echo hostname-mode=none >> /etc/NetworkManager/NetworkManager.conf
cp ./gentoo-rules-save /var/lib/iptables/rules-save
#TODO ipv6 version of this
cp ./issue /etc/issue
bash ./auditd.sh
cp ig-pentoo-ssh.conf /etc/ssh/sshd_config.d
/etc/init.d/sshd restart
#for normal non-full pentoo
#daemons to configure
emerge mdadm
emerge mail-mta/sendmail
echo net-analyzer/suricata ~amd64 >> /etc/portage/package.accept_keywords
echo net-libs/libhtp ~amd64 >> /etc/portage/package.accept_keywords
echo sec-keys/openpgp-keys-oisf >> /etc/portage/package.accept_keywords
emerge net-analyzer/suricata
emerge app-antivirus/clamav
emerge sys-process/audit
emerge net-proxy/privoxy
emerge logrotate
emerge sys-apps/smartmontools
emerge --config dev-db/postgresql:15
emerge sys-apps/haveged
emerge sys-apps/rng-tools
emerge app-admin/sysstat
emerge app-admin/gkrellm
emerge app-misc/screen
#disk usage graph
emerge sys-apps/baobab
echo app-forensics/lynis ~amd64 >> /etc/portage/package.accept_keywords
emerge app-forensics/lynis
#apps to run
#dd has status=progress now emerge dclfdd
emerge terminator
emerge media-gfx/gimp
#preinstalled now emerge media-gfx/geeqie
emerge app-crypt/steghide
emerge app-misc/binwalk
emerge net-analyzer/arp-scan
emerge net-analyzer/dirsearch
emerge net-analyzer/ffuf
emerge net-analyzer/masscan
emerge net-analyzer/testssl
emerge net-analyzer/xsstrike
emerge net-analyzer/iftop
emerge net-analyzer/multimon-ng
emerge net-analyzer/metasploit
emerge net-wireless/uhd
emerge net-wireless/airgeddon
echo dev-libs/libnl ~amd64 >> /etc/portage/package.accept_keywords
sed -i 's/opencl/opencl utils/g' /etc/portage/make.conf
emerge opencl
emerge opencl-headers
emerge clinfo
emerge net-wireless/wavemon
echo net-wireless/horst ~amd64 >> /etc/portage/package.accept_keywords
emerge net-wireless/horst
emerge net-wireless/eaphammer
emerge net-wireless/urh
emerge net-wireless/rfcat
emerge sys-apps/hwinfo
emerge media-video/mpv
emerge media-tv/v4l-utils
emerge media-sound/audacity
emerge  --autounmask-write --autounmask media-sound/supercollider
emerge libheif
emerge app-arch/bzip2
emerge lshw
emerge app-misc/mc
emerge net-mail/swaks
emerge =dev-lang/python-2*
emerge dev-python/pip
emerge dev-python/notebook
emerge dev-python/jq
emerge dev-python/selenium
emerge dev-python/requests
emerge dev-embedded/sdcc
emerge net-firewall/ipset
emerge net-irc/irssi
emerge dev-python/csvkit
emerge app-admin/keepassxc
emerge app-office/libreoffice-bin
emerge net-p2p/transmission
emerge net-im/pidgin
emerge net-im/signal-desktop-bin
emerge net-im/discord
emerge www-client/firefox-bin
echo "*/* google-chrome" > /etc/portage/package.license
echo www-client/google-chrome-unstable ~amd64 >> /etc/portage/package.accept_keywords
emerge www-client/google-chrome-unstable 
emerge mail-client/thunderbird-bin
emerge mail-client/alpine
emerge media-video/cheese
emerge app-exploits/routersploit
emerge app-forensics/yara
emerge app-forensics/bulk_extractor
emerge app-forensics/zsteg
emerge app-forensics/eagleeye
emerge dev-util/strace
#unstable packages segfault or wont install
#emerge net-wireless/btscanner
emerge sys-apps/inxi
emerge net-wireless/blue_hydra
emerge net-wireless/dump1090
emerge net-wireless/gr-osmosdr
emerge net-wireless/gr-rds
emerge net-wireless/gqrx-scanner
emerge net-wireless/mdk
emerge app-text/xpdf
emerge games-roguelike/nethack
#virtualization
emerge app-containers/docker
emerge app-containers/docker-compose
emerge app-containers/docker-cli
emerge app-emulation/libvirt
emerge app-emulation/virt-manager
emerge app-emulation/virtualbox
