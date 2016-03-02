#!/bin/bash
# This script will check to see if the system is getting network
# connectivity through the VPN.  If the network is either
# inaccessible (6) or if the IP I am talking out of is in Raleigh
# (0) I will reboot.  Sort of extreme, but it should come back 
# up with the correct network information.  I am utilizing the
# motd stuff from Ubuntu because that's where this script is run.
##
# This script will likely be called from a cronjob

location=$(curl -ks https://www.dnsleaktest.com | grep -A1 Hello);

if [[ -z $location ]] || $(echo $location | grep -i Raleigh); then
  /etc/update-motd.d/50-landscape-sysinfo | sed -e '/Graph/d' -e '/canonical/d' >> /root/reboot.log;
  echo "[$location]" >> /root/reboot.log;
  /sbin/reboot;
fi;

exit;
