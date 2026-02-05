#!/bin/bash

# Configuration Variables for local mail relay and internet server
HOSTNAME="mail.example.com"
DOMAIN="example.com"
LOCAL_NET="127.0.0.0/8, 192.168.0.0/16"

echo "--- Starting Mail Server Setup for $HOSTNAME ---"

# 1. Update and Install Packages
dnf update -y
dnf install -y postfix dovecot openssl s_nail

# 2. Set Hostname
hostnamectl set-hostname $HOSTNAME

# 3. Generate Self-Signed SSL Certificates (For Testing)
# In production, replace these with Let's Encrypt certificates.
CERT_DIR="/etc/pki/tls/mail"
mkdir -p $CERT_DIR
openssl req -new -x509 -nodes -out "$CERT_DIR/mailserver.crt" \
    -keyout "$CERT_DIR/mailserver.key" -days 365 \
    -subj "/C=US/ST=State/L=City/O=Internet Goods/CN=$HOSTNAME"
chmod 600 $CERT_DIR/mailserver.key

# 4. Configure Postfix (MTA)
echo "Configuring Postfix..."
postconf -e "myhostname = $HOSTNAME"
postconf -e "mydomain = $DOMAIN"
postconf -e "myorigin = \$mydomain"
postconf -e "inet_interfaces = all"
postconf -e "mydestination = \$myhostname, localhost.\$mydomain, localhost, \$mydomain"
postconf -e "mynetworks = $LOCAL_NET"
postconf -e "home_mailbox = Maildir/"

# SASL and TLS Configuration for Postfix
postconf -e "smtpd_sasl_type = dovecot"
postconf -e "smtpd_sasl_path = private/auth"
postconf -e "smtpd_sasl_auth_enable = yes"
postconf -e "smtpd_tls_cert_file = $CERT_DIR/mailserver.crt"
postconf -e "smtpd_tls_key_file = $CERT_DIR/mailserver.key"
postconf -e "smtpd_tls_security_level = may"
postconf -e "smtpd_relay_restrictions = permit_mynetworks, permit_sasl_authenticated, reject_unauth_destination"

# 5. Configure Dovecot (MDA & SASL Provider)
echo "Configuring Dovecot..."
sed -i 's/#protocols = imap pop3 lmtp/protocols = imap pop3/' /etc/dovecot/dovecot.conf
sed -i 's|#mail_location =|mail_location = maildir:~/Maildir|' /etc/dovecot/conf.d/10-mail.conf

# Enable Plaintext Auth (Internal/TLS only)
sed -i 's/#disable_plaintext_auth = yes/disable_plaintext_auth = no/' /etc/dovecot/conf.d/10-auth.conf

# Set up Postfix-compatible Auth Socket
cat <<EOF > /etc/dovecot/conf.d/10-master.conf
service auth {
  unix_listener /var/spool/postfix/private/auth {
    mode = 0660
    user = postfix
    group = postfix
  }
}
EOF

# 6. Configure Firewall
echo "Opening Firewall Ports..."
firewall-cmd --permanent --add-service={smtp,smtps,submission,imap,imaps}
firewall-cmd --reload

# 7. SELinux Adjustments
echo "Setting SELinux Booleans..."
setsebool -P allow_postfix_local_write_mail_spool 1
setsebool -P postfix_local_write_mail_spool 1
# Ensure the certificates have the correct context
restorecon -Rv /etc/pki/tls/mail

# 8. Start and Enable Services
system_services=("postfix" "dovecot")
for service in "${system_services[@]}"; do
    systemctl enable --now $service
done

echo "--- Setup Complete! ---"
echo "Check /var/log/maillog for any immediate errors."
