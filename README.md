# Intro
Here Ill store useful scriptsfor my currently 4 machine cluster management. For each machina Ill have root access with no password. All machines have Ubuntu 16.04 installed. Moslty in my setting I assume that I have one additional machine withr root access to all the others which has a very similiar environment to rest of the machines. From there Ill copy most, but not all the settings. I assume you read every script thorugh before executing them because they are super simplistic and likely require modifictaion fro different settings.

+ Most of the scripts are meant for multiple machine remote execution but not all. Ii
+ All scripts assume root access.  I know this is not safe but Ill do it for testing environment only.
# Scripts and their functions in this repo

+ autocommit.sh - Automatically commit and push to github 
+ checkCluster.sh - Checks each cluster for errors
+ checkRemoteJavaInstall.sh - Checks thar all the machines in cluster have Java correclty installed
+ copyPublicKey.sh - Copy public key to all clusters including root used 
+ disAllowIPV6.sh copys the /etc/systctl.conf script to all machines and sources it
+ exportJavaHome.sh script tat is copied to cluster machines by remoteInstallJava.sh 
+ kernelupdate.sh 1 machine - updates cluster in the local machine 
+ remoteInstallJava.sh - installs java in remote machine, sets java home and bin 
+ shareHostFile.sh - share current machine's hosts file to specified machines in clusts
+ shareSshd_config.sh - share ssh config file with root access allowed, restart ssh service

