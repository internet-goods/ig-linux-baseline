#!/usr/bin/env bash
nvi  
#  Exit immediately if a command exits with a non-zero status
set -e

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this script as root or using sudo."
  exit 1
fi

echo "=================================================="
2026-06-11 Postfix SMTPS & SELinux Installer for Debian
echo "=================================================="

# 1. Gather User Inputs
read -p "Enter your Mail Server FQDN (e.g., mail.example.com): " MAIL_FQDN
read -p "Enter full path to SSL Certificate (CRT/PEM): " SSL_CERT
read -p "Enter full path to SSL Private Key (KEY): " SSL_KEY

if [ ! -f "$SSL_CERT" ] || [ ! -f "$SSL_KEY" ]; then
  echo "Error: Certificate or Key file not found at the specified paths."
  exit 1
fi

# 2. Update System and Install Postfix + SELinux Utilities
echo "--> Updating package lists and installing dependencies..."
export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get install -y postfix bsd-mailx policycoreutils selinux-utils

# 3. Configure Postfix main.cf
echo "--> Configuring Postfix general settings and TLS..."
postconf -e "myhostname = $MAIL_FQDN"
postconf -e "smtpd_banner = \$myhostname ESMTP \$mail_name"
postconf -e "biff = no"
postconf -e "append_dot_mydomain = no"
postconf -e "readme_directory = no"

# TLS Parameters
postconf -e "smtpd_tls_cert_file = $SSL_CERT"
postconf -e "smtpd_tls_key_file = $SSL_KEY"
postconf -e "smtpd_tls_security_level = may"
postconf -e "smtp_tls_security_level = may"
postconf -e "smtpd_tls_protocols = !SSLv2, !SSLv3, !TLSv1, !TLSv1.1"
postconf -e "smtpd_tls_mandatory_protocols = !SSLv2, !SSLv3, !TLSv1, !TLSv1.1"

# 4. Configure Postfix master.cf for SMTPS (Port 465)
echo "--> Enabling SMTPS on Port 465..."
MASTER_CF="/etc/postfix/master.cf"

# Check if smtps is already uncommented; if not, append configuration
if ! grep -q "^smtps" "$MASTER_CF"; then
  cat <<EOF >> "$MASTER_CF"

# Custom SMTPS Configuration added by script
smtps     inet  n       -       y       -       -       smtpd
  -o syslog_name=postfix/smtps
  -o smtpd_tls_wrappermode=yes
  -o smtpd_sasl_auth_enable=yes
  -o smtpd_reject_unlisted_recipient=no
  -o smtpd_recipient_restrictions=permit_sasl_authenticated,reject
  -o milter_macro_daemon_name=ORIGINATING
EOF
fi

# 5. SELinux Policy Adjustments
if selinuxenabled 2>/dev/null; then
  echo "--> SELinux is active. Applying policies..."
  
  # Ensure port 465 is labeled correctly for SMTP
  if semanage port -l | grep -q "smtp_port_t.*465"; then
    echo "Port 465 is already assigned to smtp_port_t."
  else
    echo "Assigning port 465 to smtp_port_t..."
    semanage port -a -t smtp_port_t -p tcp 465 || semanage port -m -t smtp_port_t -p tcp 465
  fi

  # Allow postfix to read the SSL certs if they are in standard/custom paths
  echo "Adjusting file contexts for Postfix SSL access..."
  semanage fcontext -a -t cert_t "$SSL_CERT" 2>/dev/null || true
  semanage fcontext -a -t cert_t "$SSL_KEY" 2>/dev/null || true
  restorecon -v "$SSL_CERT" "$SSL_KEY"

  # Allow mail daemon to use network features
  setsebool -P httpd_can_sendmail on 2>/dev/null || true
else
  echo "--> SELinux is not enabled or not installed on this Debian system. Skipping SELinux steps."
fi

# 6. Restart Postfix to Apply Changes
echo "--> Restarting Postfix service..."
systemctl restart postfix

echo "=================================================="
echo " Setup complete! Postfix is running SMTPS on 465."
echo "=================================================="
