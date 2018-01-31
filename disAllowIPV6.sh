#!/bin/bash
for i in {1..4}
do
   scp /etc/sysctl.conf root@klaster$i:/etc
   ssh -t root@klaster$i "sysctl -p; cat /proc/sys/net/ipv6/conf/all/disable_ipv6"
done
