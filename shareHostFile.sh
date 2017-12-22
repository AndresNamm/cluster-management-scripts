#!/bin/bash
for i in {1..4}
do
scp /etc/hosts root@klaster$i:/etc/hosts
done



