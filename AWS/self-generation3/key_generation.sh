#!/bin/sh

# http://docs.aws.amazon.com/fr_fr/elasticbeanstalk/latest/dg/configuring-https-ssl.html
openssl genrsa 2048 > privatekey.pem
openssl req -new -key privatekey.pem -out csr.pem


# http://stackoverflow.com/questions/18283507/elasticbeanstalk-ssl-without-custom-domain
openssl x509 -req -days 365 -in csr.pem -signkey privatekey.pem -out server.crt

