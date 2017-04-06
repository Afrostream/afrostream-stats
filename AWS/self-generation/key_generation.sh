# ne pas utiliser, amazon génère automatiquement le PEM.
ssh-keygen -t rsa
ssh-keygen -f afrostream-stats_aws_rsa.pub -m 'PEM' -e > afrostream-stats_aws_rsa.pem
