#!/bin/bash
for i in {1..4}
do 
ssh -t root@klaster$i "rm /tmp/.scm_prepare_node.lock"
done


