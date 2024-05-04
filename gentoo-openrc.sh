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
rc-update -v show
rc-status
