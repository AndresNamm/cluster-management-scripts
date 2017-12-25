#!/bin/bash
# ASSUME TO HAVE /root/.ssh directory 
for i in {1..4}
do 
ssh-copy-id klaster$i
ssh -t klaster$i "sudo cp ~/.ssh/* /root/.ssh"
done

