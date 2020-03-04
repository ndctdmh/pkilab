#!/bin/sh
#
# This script will undo the PKI SRA 221 LAB environment
#
# ==============================================
#
echo "This script will cleanup and reset the PKI lab configuration."
echo "Press ENTER to continue or ctrl-C to exit"
read input
#
echo "   Remove openssl.conf"
rm /home/seed/openssl.cnf
echo "   Remove the demoCA dir"
rm -rf demoCA
#
echo "   Remove /var/www/sra221"
rm -fr /var/www/sra221   
echo "   Remove seed-ssl.conf" 
rm /etc/apache2/sites-available/seed-ssl.conf
#
echo " "
echo "Cleanup for PKI Complete at" `date`
exit
