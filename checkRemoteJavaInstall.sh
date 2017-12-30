#!/bin/bash
for i in {1..3}
do
echo ""
echo ""
tput setaf 2
echo "KLASTER$i"
tput sgr0
ssh -t klaster$i "echo \"JAVA_HOME: $JAVA_HOME\"; echo \"JAVA & JAVAC VERSIONS\"; java -version; javac -version; echo \"UPDATE-ALTERNATIVES\"; update-alternatives --config java; update-alternatives --config javac "
echo
done



