#!/bin/bash
for i in {1..4}
do
#ssh -t root@klaster$i "mkdir -p /var/log/journal"
ssh -t root@klaster$i "systemctl restart systemd-journald"
done
