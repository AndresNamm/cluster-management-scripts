#!/bin/bash
for i in {1..4}
do 
ssh -t root@klaster$i "rm -Rf /var/lib/flume-ng /var/lib/hadoop* /var/lib/hue /var/lib/navigator /var/lib/oozie /var/lib/solr /var/lib/sqoop* /var/lib/zookeeper"
ssh -t root@klaster$i "rm -Rf /dfs /mapred /yarn" 
done
