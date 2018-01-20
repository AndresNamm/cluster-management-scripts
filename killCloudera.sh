#!/bin/bash
for u in cloudera-scm flume hadoop hdfs hbase hive httpfs hue impala llama mapred oozie solr spark sqoop sqoop2 yarn zookeeper 
do 
echo $u
echo $(ps -u $u -o pid=)
kill $(ps -u $u -o pid=)# works but starts again...
service $u stop
done



