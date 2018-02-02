#!/bin/bash
for i in {1..4}
do 
ssh -t  root@klaster$i "sync && echo 3 | sudo tee /proc/sys/vm/drop_caches"
done
