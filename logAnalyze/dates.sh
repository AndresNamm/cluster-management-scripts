#!/bin/bash
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
echo "${red}+ $1${reset}"
echo "+ Algus: $(head -n 1 $1 | grep -o -P '\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}' | head -n 1)"
echo "+ Lõpp: $(tail -n 1 $1 | grep -o -P '\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}' | head -n 1)"
