#for normal non-full pentoo
#daemons to configure
emerge mdadm
emerge mail-mta/sendmail
emerge net-analyzer/suricata
emerge app-antivirus/clamav
emerge sys-process/audit
emerge net-proxy/privoxy
emerge logrotate
emerge sys-apps/smartmontools
emerge --config dev-db/postgresql:15
emerge sys-apps/haveged
emerge app-admin/sysstat
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
emerge net-wireless/wavemon
emerge net-wireless/eaphammer
emerge net-wireless/urh
emerge net-wireless/rfcat
emerge sys-apps/hwinfo
emerge media-video/mpv
emerge media-tv/v4l-utils
emerge media-sound/audacity
emerge libheif
emerge app-arch/bzip2
emerge lshw
emerge app-misc/mc
emerge net-mail/swaks
emerge =dev-lang/python-2*
emerge dev-python/pip
emerge dev-python/notebook
emerge dev-python/jq
emerge dev-embedded/sdcc
emerge net-firewall/ipset
emerge net-irc/irssi
emerge dev-python/csvkit
emerge app-admin/keepassxc
emerge media-sound/supercollider
emerge app-office/libreoffice-bin
emerge net-p2p/transmission
emerge net-im/pidgin
emerge net-im/signal-desktop-bin
emerge net-im/discord
emerge www-client/firefox-bin
emerge www-client/google-chrome-unstable
emerge mail-client/thunderbird-bin
emerge mail-client/alpine
emerge media-video/cheese
emerge app-exploits/routersploit

emerge 
#unstable packages segfault or wont install
#emerge net-wireless/btscanner
#emerge net-wireless/horst
