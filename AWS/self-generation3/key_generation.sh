#!/bin/sh

# http://docs.aws.amazon.com/fr_fr/elasticbeanstalk/latest/dg/configuring-https-ssl.html
openssl genrsa 2048 > privatekey.pem
openssl req -new -key privatekey.pem -out csr.pem


