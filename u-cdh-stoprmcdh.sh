#!/bin/bash
for i in {1..2}
do
sudo service cloudera-scm-agent stop
sudo apt-get purge 'cloudera-manager-*' -y
sudo apt-get clean
done;
