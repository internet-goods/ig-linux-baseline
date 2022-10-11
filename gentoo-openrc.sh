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

rc-update -v show
