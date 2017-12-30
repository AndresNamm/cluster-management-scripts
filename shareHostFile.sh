#!/bin/bash
for i in {1..3}
do
scp /etc/hosts root@klaster$i:/etc/hosts
done



