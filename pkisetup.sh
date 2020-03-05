#!/bin/sh
#
# This script will setup the PKI SRA 221 LAB environment
#
# ==============================================
#
echo "This script will setup the PKI lab configuration."
echo "Press ENTER to continue or ctrl-C to exit"
read input
#
chmod 775 /home/seed/pkilab
echo "Coping the Lab doc to Desktop"
cp *.docx /home/seed/Desktop/
echo " "
#
echo "Step 1 - Setting up SSL config files"
echo "   Copying openssl.conf"
cp /usr/lib/ssl/openssl.cnf  /home/seed/
echo "   Making demoCA dir"
mkdir /home/seed/demoCA
cd /home/seed/demoCA
echo "   Creating new cert dirs under demoCA"
mkdir certs crl newcerts 
echo "   Touching index.txt and serial files"
touch index.txt serial
echo "   Setting serial input to 1000"
echo 1000 > serial
echo "   Changing dir to home"
cd ..
echo "Step 1 - Complete"
#
echo " "
echo "Step 2 - Modify openssl.cnf to policy_anything"
sed -i 's/policy_match/policy_anything/g' /home/seed/openssl.cnf
echo "   openssl.cnf updated"
#
echo "Step 3 - Setting Up SRA 221 Hello Webpage"
echo "   Change to /var/www and create the sra221 dir"
cd /var/www
sudo mkdir sra221   
cd sra221
echo "   Create a basic Welcome Page"
echo "<html>" > index.html
echo "<body>" >> index.html
echo "<h1>Hello Welcome to SRA 221</h1>" >> index.html
echo "</body>" >> index.html
echo "</html>" >> index.html
echo "   Page created in index.html"
#
echo "Step 4 - Create Apache ssl config"
echo "   Change dir /etc/apache2/sites-available"
cd /etc/apache2/sites-available
echo "   Adding config lines to seed-ssl.conf" 
{
echo "<VirtualHost *:443>"
echo "ServerName sra221.com"
echo "DocumentRoot /var/www/sra221"
echo "DirectoryIndex index.html"
echo "SSLEngine On"
echo "SSLCertificateFile /home/seed/server.crt"
echo "SSLCertificateKeyFile /home/seed/server.key"
echo "</VirtualHost>"
} >/etc/apache2/sites-available/seed-ssl.conf
#
echo "Step 5 - Change /etc/hosts to resolve 127.0.0.1 to SRA221.com "
 echo "127.0.0.1 sra221.com" >>/etc/hosts
echo "   Host file Updated"
#
echo "   Changing dir to home"
cd /home/seed
echo " "
echo "Setup for PKI Complete at" `date`
