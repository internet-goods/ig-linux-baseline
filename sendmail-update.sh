m4 /usr/share/sendmail-cf/m4/cf.m4 /etc/mail/sendmail.mc > /etc/mail/sendmail.cf
m4 /usr/share/sendmail-cf/m4/cf.m4 /etc/mail/submit.mc > /etc/mail/submit.cf
makemap hash /etc/mail/access.db < /etc/mail/access
newaliases
rc-service sendmail restart
systemctl restart sendmail
