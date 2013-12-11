#!/bin/bash
#/etc/network/if-up.d/update_hosts
# stolen from http://www.onepwr.org/2012/04/26/chef-recipe-to-setup-up-a-new-nodes-fqdn-hostname-etc-properly/
set -e

# Variable IFACE is setup by Ubuntu network init
# scripts to whichever interface changed status.
[ "$IFACE" == "eth0" ] || exit

node_fqdn=`cat /etc/hostname`
node_shortname=`cat /etc/hostname | cut -d "." -f1`
hostsfile="/etc/hosts"
# Knock out line with "old" IP
sed -i '/ '${node_fqdn}'/ d' ${hostsfile}
ipaddr=$(ifconfig eth0 | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')
echo "#"
echo "# Updated at `date`" >> ${hostsfile}
echo "$ipaddr $node_fqdn $node_shortname" >> ${hostsfile}