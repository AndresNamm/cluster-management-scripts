#!/bin/bash
for i in {2,4}
do
scp /etc/hosts root@klaster$i:/etc/hosts
done



