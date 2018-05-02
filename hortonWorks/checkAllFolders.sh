#!/bin/sh
for folder in 'input/logDirs input/hadoopDirs input/configDirs input/pidDirs input/libDirs'
do 
bash checkFolders.sh all $folder
done 
