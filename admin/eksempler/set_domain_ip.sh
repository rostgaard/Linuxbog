#!/bin/sh

############################################################################
####################
### 30/12-2001 Michael Rasmussen.
### 
### Copyright 2001, Michael Rasmussen under GPL.
### mir@miras.org
###
###
###
### Revision history
###
### Version 0.1:   Initial script
###
### Installation (Redhat 7.x)
###
### 1) Log in as root (su -)
### 2) Copy the script to /etc/rc.d/init.d
### 3) Chmod 700 /etc/rc.d/init.d/set_domain_ip.sh
### 4) Open the file /etc/rc.d/rc.local in your favorit editor
### 5) Write at the bottom: /etc/rc.d/init.d/set_domain_ip.sh
###    
############################################################################
####################

dev=eth0
hosts=/etc/hosts

eth0=`ifconfig $dev|grep inet|awk -F: '{print $2}'|awk '{print $1}'`

nickname=`echo $HOSTNAME|awk -F. '{print $1}'`

echo  "############################################################" > $hosts
echo  "############################################################" >> $hosts
echo  "##                                                        ##" >> $hosts
echo  "## This host file is generated automatically at startup   ##" >> $hosts
echo  "## Do not remove the following lines, or various programs ##" >> $hosts
echo  "## that require network functionality will fail.          ##" >> $hosts 
echo  "##                                                        ##" >> $hosts
echo  "############################################################" >> $hosts
echo  "############################################################" >> $hosts
echo >> $hosts
echo  "# Loop back Interface" >> $hosts
echo -e "127.0.0.1\tlocalhost.localdomain\tlocalhost" >> $hosts
echo >> $hosts
echo  "# "$dev" Interface" >> $hosts
echo -e $eth0"\t"$HOSTNAME"\t"$nickname  >> $hosts

exit 0
