rc-service smartd start
rc-update add smartd
rc-service smartd sendmail
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

rc-update -v show
