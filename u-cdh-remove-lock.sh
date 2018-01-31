#!/bin/bash
for i in {1..3}
do 
ssh -t root@klaster$i  "rm /tmp/.scm_prepare_node.lock"
done;
