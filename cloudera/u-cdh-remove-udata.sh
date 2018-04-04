#!/bin/bash
echo "Removing cloudera related data"
rm -Rf /var/lib/flume-ng /var/lib/hadoop* /var/lib/hue /var/lib/navigator /var/lib/oozie /var/lib/solr /var/lib/sqoop* /var/lib/zookeeper
rm -Rf /dfs /mapred /yarn /newdisk1/dfs
