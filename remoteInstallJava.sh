#!/bin/bash
# we are assuming that nothing has been already installed in /usr/java before
# you have to fill the variables below according to your own needs.
set -e
jdk="jdk1.8.0_131"
javatar="/usr/java/jdk1.8.0_131.tar.gz"
javaHome="./exportJavaHome.sh"
for i in {2..2}
do 
echo "INSTALLING TO: klaster$i"
echo "COPYING AND EXTRACTING JAVA" 
ssh -t root@klaster$i "mkdir /usr/java || echo \"dir exists\""
scp $javatar root@klaster$i:/usr/java
ssh -t root@klaster$i "tar -xzvf /usr/java/$jdk.tar.gz -C /usr/java || exit 1; ls -l /usr/java;"
echo "COPYING THE JAVA_HOME CONFIGURATION"
scp $javaHome root@klaster$i:/etc/profile.d
ssh -t root@klaster$i "source /etc/profile; echo \"JAVA_HOME:  $JAVA_HOME\"| exit 1"
echo "UPDATE ALTERNATIVES"
ssh -t root@klaster$i "update-alternatives --install /usr/bin/java java /usr/java/$jdk/jre/bin/java 2000; update-alternatives --config java; java -version"
ssh -t root@klaster$i "update-alternatives --install /usr/bin/javac javac /usr/java/$jdk/bin/javac 2000; update-alternatives --config javac; javac -version"
done 
