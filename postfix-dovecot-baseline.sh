#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Helper Functions ---
error_exit() {
    echo -e "\e[31m[ERROR]\e[0m $1" >&2
    exit 1
}

log_info() {
    echo -e "\e[32m[INFO]\e[0m $1"
}

usage() {
    echo "Usage: $0 -d <domain> -h <mail_hostname> -c <cert_path> -k <key_path>"
    echo "  -d : Base domain (e.g., example.com)"
    echo "  -h : Mail server FQDN (e.g., mail.example.com)"
    echo "  -c : Absolute path to the SSL/TLS Certificate (e.g., /etc/letsencrypt/live/mail.example.com/fullchain.pem)"
    echo "  -k : Absolute path to the SSL/TLS Private Key (e.g., /etc/letsencrypt/live/mail.example.com/privkey.pem)"
    exit 1
}

# --- Parse Arguments ---
while getopts "d:h:c:k:" opt; do
    case "${opt}" in
        d) DOMAIN="${OPTARG}" ;;
        h) MAIL_HOST="${OPTARG}" ;;
        c) CERT_PATH="${OPTARG}" ;;
        k) KEY_PATH="${OPTARG}" ;;
        *) usage ;;
    esac
done

if [[ -z "$DOMAIN" || -z "$MAIL_HOST" || -z "$CERT_PATH" || -z "$KEY_PATH" ]]; then
    usage
fi

# Ensure running as root
if [ "$EUID" -ne 0 ]; then
    error_exit "This script must be run as root (or via sudo)."
fi

# Verify Certificate files exist
if [ ! -f "$CERT_PATH" ] || [ ! -f "$KEY_PATH" ]; then
    error_exit "Certificate or Private Key path does not exist."
fi

# --- Step 1: Install Required Packages ---
log_info "Updating package lists and installing Postfix, Dovecot, and SELinux utilities..."
export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get install -y postfix dovecot-core dovecot-imapd policycoreutils selinux-utils

# --- Step 2: Postfix SELinux Adaptation (Disable Chroot) ---
log_info "Configuring Postfix for Debian SELinux compatibility (disabling chroot)..."
# Block Debian's init script from auto-syncing chroot structures
if [ -f /etc/default/postfix ]; then
    sed -i 's/^SYNC_CHROOT=.*/SYNC_CHROOT="n"/' /etc/default/postfix
else
    echo 'SYNC_CHROOT="n"' >> /etc/default/postfix
fi

# --- Step 3: Configure Postfix (SMTP / SMTPS) ---
log_info "Configuring Postfix (main.cf)..."

cat << EOF > /etc/postfix/main.cf
# General Settings
myhostname = $MAIL_HOST
mydomain = $DOMAIN
myorigin = \$mydomain
inet_interfaces = all
inet_protocols = all
mydestination = localhost.\$mydomain, localhost

# TLS Settings
smtpd_tls_cert_file = $CERT_PATH
smtpd_tls_key_file = $KEY_PATH
smtpd_tls_security_level = may
smtpd_tls_auth_only = yes
smtpd_tls_protocols = !SSLv2, !SSLv3, !TLSv1, !TLSv1.1
smtpd_tls_mandatory_protocols = !SSLv2, !SSLv3, !TLSv1, !TLSv1.1
tls_high_cipherlist = EECDH+ECDSA+AESGCM:EECDH+aRSA+AESGCM:EECDH+ECDSA+SHA384:EECDH+IA_RSA+SHA384:EECDH+ECDSA+SHA256:EECDH+aRSA+SHA256

# Dovecot SASL Authentication Backend
smtpd_sasl_type = dovecot
smtpd_sasl_path = private/auth
smtpd_sasl_auth_enable = yes
smtpd_recipient_restrictions = permit_sasl_authenticated, permit_mynetworks, reject_unauth_destination

# Virtual Mailbox Settings (Simplifying to standard local system mapping for base setup)
virtual_alias_maps = hash:/etc/postfix/virtual
EOF

touch /etc/postfix/virtual
postmap /etc/postfix/virtual

log_info "Configuring Postfix Services (master.cf) for SMTP, Submission (587) and SMTPS (465)..."
# Overwrite/Append master.cf ensuring no services utilize chroot ("n" in the 5th column)
cat << EOF > /etc/postfix/master.cf
# service type  private unpriv  chroot  wakeup  maxproc command + args
smtp      inet  n       -       n       -       -       smtpd
submission inet n       -       n       -       -       smtpd
  -o smtpd_tls_security_level=encrypt
  -o smtpd_sasl_auth_enable=yes
  -o smtpd_client_restrictions=permit_sasl_authenticated,reject
smtps     inet  n       -       n       -       -       smtpd
  -o smtpd_tls_wrappermode=yes
  -o smtpd_sasl_auth_enable=yes
  -o smtpd_client_restrictions=permit_sasl_authenticated,reject
pickup    unix  n       -       n       -       60      pickup
cleanup   unix  n       -       n       -       0       cleanup
qmgr      unix  n       -       n       -       1       qmgr
tlsmgr    unix  n       -       n       -       1       tlsmgr
rewrite   unix  n       -       n       -       -       trivial-rewrite
bounce    unix  n       -       n       -       0       bounce
defer     unix  n       -       n       -       0       bounce
trace     unix  n       -       n       -       0       bounce
verify    unix  n       -       n       -       1       verify
flush     unix  n       -       n       -       0       flush
proxymap  unix  n       -       n       -       -       proxymap
proxywrite unix n       -       n       -       1       proxymap
smtp      unix  n       -       n       -       -       smtp
relay     unix  n       -       n       -       -       smtp
showq     unix  n       -       n       -       -       showq
error     unix  n       -       n       -       -       error
retry     unix  n       -       n       -       -       error
discard   unix  n       -       n       -       -       discard
local     unix  -       n       n       -       -       local
virtual   unix  -       n       n       -       -       virtual
lmtp      unix  -       n       n       -       -       lmtp
anvil     unix  n       -       n       -       1       anvil
scache    unix  n       -       n       -       1       scache
EOF

# --- Step 4: Configure Dovecot (IMAP / IMAPS & SASL) ---
log_info "Configuring Dovecot..."

# Consolidating configurations into a clean, modern file
cat << EOF > /etc/dovecot/dovecot.conf
# Protocols
protocols = imap

# SSL Configuration
ssl = required
ssl_cert = <$CERT_PATH
ssl_key = <$KEY_PATH
ssl_min_protocol = TLSv1.2
ssl_cipher_list = ALL:!LOW:!SSLv2:!SSLv3:!EXPORT:!ADH:!eNULL;

# Mail Location (Standard Maildir layout in user home directories)
mail_location = maildir:~/Maildir

# Authentication
auth_mechanisms = plain login
passdb {
  driver = pam
}
userdb {
  driver = passwd
}

# Postfix SMTP Auth Socket Configuration
service auth {
  unix_listener /var/spool/postfix/private/auth {
    mode = 0660
    user = postfix
    group = postfix
  }
}

# Logging
log_path = /var/log/dovecot.log
info_log_path = /var/log/dovecot-info.log
EOF

# --- Step 5: SELinux Contexts and Labeling ---
log_info "Applying SELinux security context adjustments..."

if selinuxenabled; then
    # 1. Allow Postfix to interact with Dovecot's authentication sockets
    setsebool -P postfix_local_write_mail_spool on 2>/dev/null || true
    
    # 2. Correct context for system SSL certs if they are placed outside default paths
    # (If using Let's Encrypt /etc/letsencrypt paths, ensure the context allows mail domain read)
    log_info "Restoring SELinux contexts for mail directories..."
    restorecon -Rv /etc/postfix
    restorecon -Rv /etc/dovecot
else
    log_info "SELinux is installed but not currently enforcing. Skipping live context re-labeling."
fi

# --- Step 6: Restart Services ---
log_info "Restarting Postfix and Dovecot..."
systemctl restart postfix
systemctl restart dovecot

log_info "Mail server configuration complete!"
echo "--------------------------------------------------------"
echo " SMTP / Submission / SMTPS & IMAP / IMAPS are active."
echo " Ensure your firewall has ports 25, 465, 587, and 993 open."
echo "--------------------------------------------------------"
#sudo ./deploy_mail.sh \
#  -d example.com \
#  -h mail.example.com \
#  -c /etc/letsencrypt/live/mail.example.com/fullchain.pem \
#  -k /etc/letsencrypt/live/mail.example.com/privkey.pem
