#!/bin/sh
#
# chkconfig: 35 11 99
# description: set FQDN and modify /etc/hosts in braindead DHCP environments
# processname: N/A
# config: N/A
# pidfile: N/A
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
###	Version 0.2:   Applied support for chkconfig by Kristian Vilmann
###
### Installation (Redhat 7.x)
###
### 1) Log in as root (su -)
### 2) Copy the script to /etc/rc.d/init.d/set_domain_ip
### 3) Chmod 700 /etc/rc.d/init.d/set_domain_ip
### 4) Run /sbin/chkconfig --add set_domain_ip
###    
############################################################################
####################

case "$1" in
  start)
	# Fall through
	;;
  stop)
	# Exit Now
	exit 0
	;;
esac
	 
dev=eth0
hosts=/etc/hosts

eth0=`/sbin/ifconfig $dev|grep inet|awk -F: '{print $2}'|awk '{print $1}'`

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
