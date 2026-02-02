#!/bin/bash                                                                                                                                                                                                        
# Check if domain argument is provided                                                                                                                                                                             
if [ -z "$1" ]; then                                                                                                                                                                                               
    echo "Usage: $0 <domain.com>"                                                                                                                                                                                  
    exit 1                                                                                                                                                                                                         
fi                                                                                                                                                                                                                 
                                                                                                                                                                                                                   
DOMAIN=$1                                                                                                                                                                                                          
                                                                                                                                                                                                                   
# Fetch location data based on your current public IP                                                                                                                                                              
echo "Fetching location data..."                                                                                                                                                                                   
LOCATION_DATA=$(curl -s http://ip-api.com/json/)

# Parse location data using jq
COUNTRY=$(echo $LOCATION_DATA | jq -r '.countryCode')
STATE=$(echo $LOCATION_DATA | jq -r '.regionName')
CITY=$(echo $LOCATION_DATA | jq -r '.city')
ORG=$(echo $LOCATION_DATA | jq -r '.org')

# Create the openssl.cnf file
cat <<EOF > $1.openssl.cnf
[ req ]
default_bits       = 8192
distinguished_name = req_distinguished_name
req_extensions     = v3_req
prompt             = no

[ req_distinguished_name ]
C            = $COUNTRY
ST           = $STATE
L            = $CITY
O            = $ORG
OU           = $1 IT Department
CN           = $DOMAIN

[ v3_req ]
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = $DOMAIN
DNS.2 = www.$DOMAIN
DNS.3 = mail.$DOMAIN
EOF

echo "Success! openssl.cnf created for $DOMAIN in $CITY, $STATE."
docker run -v /tmp/certs:/certs -e SSL_CONFIG=$1.openssl.cnf -e SSL_SIZE=8192 -e SSL_EXPIRE=365 -e CA_SUBJECT=$1-ca -e CA_KEY=$1-ca-key.pem -e CA_CERT=$1-ca.pem -e SSL_KEY=$1-cert-key.pem -e SSL_CSR=$1-cert.csr -e SSL_CERT=$1-cert.pem -e SSL_SUBJECT=$1 -e SSL_DNS=www.$1,mail.$1 paulczar/omgwtfssl
mv /tmp/certs $1.certs
