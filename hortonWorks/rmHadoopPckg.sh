#!/bin/bash 
machines=$1 
packages=$2
for package in $(cat $packages)
do
echo $package 
clush -l root -g $machines yum remove $package -y
done













