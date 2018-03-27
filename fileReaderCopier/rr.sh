#!/bin/bash
while IFS='' read -r line || [[ -n "$line" ]]; do
    echo "Text read from file: $line"
    ls -la $line 
    hdfs dfs -Ddfs.block.size=128000000 -put $line /user/andres/http/2018_01_01 || exit
done < "$1"

