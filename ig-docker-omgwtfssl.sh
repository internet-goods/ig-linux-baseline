docker run -v /tmp/certs:/certs  -e SSL_SIZE=8192 -e SSL_EXPIRE=365 -e SSL_SUBJECT=$1 paulczar/omgwtfssl
mv /tmp/certs /root/$1.certs
