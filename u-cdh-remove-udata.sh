#!/bin/bash
#for i in {1..4}
#do
umount cm_processes 
echo "removing cloudera related data"
rm -Rf /usr/share/cmf /var/lib/cloudera* /var/cache/yum/cloudera* /var/log/cloudera* /var/run/cloudera*
rm -Rf /var/lib/flume-ng /var/lib/hadoop* /var/lib/hue /var/lib/navigator /var/lib/oozie /var/lib/solr /var/lib/sqoop* /var/lib/zookeeper
rm -Rf /dfs /mapred /yarn /newdisk1/dfs
#done
