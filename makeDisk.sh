#!/bin/bash
#https://www.digitalocean.com/community/tutorials/how-to-partition-and-format-storage-devices-in-linux
sudo parted /dev/sdb mklabel gpt && 
sudo parted -a opt /dev/sdb mkpart primary ext4 0% 100% &&
lsblk &&
sudo mkfs.ext4 -L datapartition /dev/sdb1 &&
sudo mkdir -p /newdisk1 &&
sudo mount -o defaults /dev/sdb1 /newdisk1 
#sudo echo "LABEL=datapartition /newdisk1 ext4 defaults 0 2" >> /etc/fstab
