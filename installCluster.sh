#!/bin/bash

# Check if root read -p 'Add groups?' -n 1 -r
read -p 'ARE YOU IN ROOT RIGHTS? YOU MUST BEEE' -n 1 -r
if [[!  $REPLY =~ ^[Yy]$ ]]
then
exit 1 
fi

# GROUP adding 
echo "Checking existance"
groupa=(hadoopadm hadoop)
for item in ${groupa[*]}
do 
  cut -d: -f1 /etc/group | grep $item
done
read -p 'Add groups?' -n 1 -r
echo
if [[  $REPLY =~ ^[Yy]$ ]]
then   
   groupadd -g 6000 hadoopadm
   groupadd -g 6006 hadoop
fi
# ADD GROUPS TO SUDOERS  
echo "Checking groups for sudoers "
cat /etc/sudoers | grep wheel 
read -p 'Add wheel group? ' -n 1 -r </dev/tty
echo
if [[  $REPLY =~ ^[Yy]$ ]]
then   
   echo "%wheel ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers  
   systemctl restart sshd.service
   systemctl status sshd.service
fi

cat /etc/sudoers | grep hadoop  
read -p 'Add hadoop group? ' -n 1 -r </dev/tty
echo
if [[  $REPLY =~ ^[Yy]$ ]]
then      
   echo "%hadoopadm  ALL=NOPASSWD: /bin/su - hdfs, /bin/su - oozie, /etc/init.d/ambari-agent stop, /etc/init.d/ambari-agent start, /etc/init.d/ambari-agent restart, /usr/sbin/tcpdump, /bin/su - hive, /bin/su hive, /bin/su - flume, /bin/su flume, /bin/su - yarn, /bin/su yarn, /bin/su - falcon, /bin/su falcon, /bin/su zookeeper, /bin/su - zookeeper, /bin/su - ranger, /bin/su ranger" >> /etc/sudoers
   systemctl restart sshd.service
   systemctl status sshd.service
fi

# ADD USERS IN GROUPS 
echo "Do you want to add users? "
directory="users"
for f in "$directory"/*; 
do 
   cut -d: -f1 /etc/passwd | grep $(basename "$f")    
done
  
read -p 'Add users? ' -n 1 -r </dev/tty 
echo
if [[  $REPLY =~ ^[Yy]$ ]]
then
for f in "$directory"/*; 
  do 
      bash $f 
  done  
fi

# HOSTNAME CONFIGURATION 
echo "Configuring FQDB hostname"
echo 'hostname command & cat /etc/resolv.conf'
hostname
cat /etc/resolv.conf
read -p 'Modify /etc/resolv.conf? ' -n 1 -r </dev/tty 
echo
if [[  $REPLY =~ ^[Yy]$ ]]
then
echo  "search estpak.ee
nameserver 84.50.226.42
nameserver 84.50.226.90" >> /etc/resolv.conf
fi
echo 'command: cat /etc/hostname'
cat /etc/hostname
read -p 'Modify /etc/hostname? ' -n 1 -r </dev/tty 
echo
if [[  $REPLY =~ ^[Yy]$ ]]
then
read -p "Give me the FQDN " -r fqdn </dev/tty
echo $fqdn > /etc/hostname
hostnamectl set-hostname $fqdn
hostname -f 
hostname 
fi

#	Disableda "selinux" 
echo 'cat  /etc/selinux/config  | grep "^SELINUX=.\+"'
cat  /etc/selinux/config  | grep "^SELINUX=.\+"
# https://www.gnu.org/software/sed/manual/sed.html good regex tutorial
read -p "Disable SELINUX? " -n 1 -r </dev/tty 
echo
if [[  $REPLY =~ ^[Yy]$ ]]
then
sed -i.bak -r s/^SELINUX=.+/SELINUX=disabled/ /etc/selinux/config 
cat /etc/selinux/config | grep "^SELINUX=.\+"
fi 

# STOP firewall 

systemctl status firewalld
read -p "Stop Firewall? " -n 1 -r </dev/tty
echo
if [[  $REPLY =~ ^[Yy]$ ]]
then
systemctl stop firewalld
systemctl disable firewalld
systemctl status firewalld
fi


# Install additional software

read -p "Install additional software? " -n 1 -r </dev/tty
echo
if [[  $REPLY =~ ^[Yy]$ ]]
then
yum update
yum install -y mc scp curl unzip tar wget zlib-devel lzo-devel ntp nano krb5-workstation vim screen gdisk iftop bind-utils usbutils libX11 opensc
fi


# Set Ulimit 

echo 'cat /etc/security/limits.conf | grep 'soft nofile 65536\|hard nofile 65536''
cat /etc/security/limits.conf | grep 'soft nofile 65536\|hard nofile 65536'
read -p "Set ulimit? " -n 1 -r </dev/tty
if [[  $REPLY =~ ^[Yy]$ ]]
then
echo "* soft nofile 65536
* hard nofile 65536" >> /etc/security/limits.conf
fi

# Configure NTPD 
systemctl status ntpd 
echo 'cat /etc/ntp.conf | grep 'server ntp.estpak.ee prefer''
cat /etc/ntp.conf | grep 'server ntp.estpak.ee prefer'
read -p "Configure NTPD? " -n 1 -r </dev/tty
echo 
if [[  $REPLY =~ ^[Yy]$ ]]
then
echo "server ntp.estpak.ee prefer" >>/etc/ntp.conf
systemctl start ntpd
systemctl enable ntpd
systemctl status ntpd
fi

# COPY kerbero configurations

read -p "Conf Kerberos and allow root login access to some computers? " -n 1 -r </dev/tty
echo
if [[  $REPLY =~ ^[Yy]$ ]]
then
read -p "What server /bryht.estpak.ee or elemmire.estpak.ee? " -r srv </dev/tty
echo 
scp  $srv:/etc/krb5.conf /etc/krb5.conf
mkdir /root/.ssh
sudo scp $srv:/root/.ssh/authorized_keys /root/.ssh/authorized_keys
fi

# PARTITIONING GPT and EXT4 filesystems 
# https://www.digitalocean.com/community/tutorials/how-to-partition-and-format-storage-devices-in-linux
lsblk --fs  
cat /etc/fstab 
read -p "Partitioning? " -n 1 -r </dev/tty
echo
if [[  $REPLY =~ ^[Yy]$ ]]
then
	read -p "Datanode or NameNode?  " -r srv </dev/tty
	echo 
	if [[  "$srv" = "datanode" ]]
	then
		for disk in sda sdb sdc sdd sde sdf sdg sdh sdi sdj sdk sdl sdm sdn sdo sdp 
		do
			# Add GPT 
			sudo parted /dev/"$disk" mklabel gpt
			# Add partition
			sudo parted -a opt /dev/"$disk" mkpart primary ext4 0% 100%
			# Format partition as Ext4
			mkfs.ext4 -L datapartition_"$disk" /dev/"$disk"1
		done
		cat /etc/fstab
		read -p "Modify fstab as well? " -n 1 -r </dev/tty
                cp /etc/fstab /root/
		if [[  $REPLY =~ ^[Yy]$ ]]
				then
			# Add lines to FSTAB
				cnt=1 
				for disk in sda sdb sdc sdd sde sdf sdg sdh sdi sdj sdk sdl sdm sdn sdo sdp
				do
					mkdir /grid"$cnt"
					echo "/dev/"$disk"1                /grid"$cnt"                  ext4    noatime        0 2" >>/etc/fstab 
					cnt=$(($cnt+1))
				done
		fi
		
	fi
fi

# CONFIGURE NETWORK 

echo "eno49 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
cat /etc/sysconfig/network-scripts/ifcfg-eno49
echo "eno50 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
cat /etc/sysconfig/network-scripts/ifcfg-eno50
echo "team0 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
cat /etc/sysconfig/network-scripts/ifcfg-team0
read -p "Configure network? " -n 1 -r </dev/tty
echo
if [[  $REPLY =~ ^[Yy]$ ]]
then
	read -p "What is the ip Adress? " -r ipadr</dev/tty
	echo
	read -p "What is the Gateway? " -r gatway</dev/tty
	echo
        read -p "Want to backup netConf ? Warning, this will delete older backups " -n 1 -r </dev/tty
	echo
	if [[  $REPLY =~ ^[Yy]$ ]]
	then
		mkdir /root/network-scripts
		mv /etc/sysconfig/network-scripts/ifcfg-eno49 /root/network-scripts
		mv /etc/sysconfig/network-scripts/ifcfg-eno50 /root/network-scripts
		mv /etc/sysconfig/network-scripts/ifcfg-team0 /root/network-scripts
	else
        
		rm /etc/sysconfig/network-scripts/ifcfg-eno49
		rm /etc/sysconfig/network-scripts/ifcfg-eno50
		rm /etc/sysconfig/network-scripts/ifcfg-team0

	fi 
        
	cat network-conf/ifcfg-team0 >> /etc/sysconfig/network-scripts/ifcfg-team0
	sed -i.bak -r s/ip\.address\.here/"$ipadr"/ /etc/sysconfig/network-scripts/ifcfg-team0
	sed -i.bak -r s/gw\.address\.here/"$gatway"/ /etc/sysconfig/network-scripts/ifcfg-team0
	cat network-conf/ifcfg-eno50 >> /etc/sysconfig/network-scripts/ifcfg-eno50
	cat network-conf/ifcfg-eno49 >> /etc/sysconfig/network-scripts/ifcfg-eno49   

	echo "eno49 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
	cat /etc/sysconfig/network-scripts/ifcfg-eno49
	echo "eno50 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
	cat /etc/sysconfig/network-scripts/ifcfg-eno50
	echo "team0 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
	cat /etc/sysconfig/network-scripts/ifcfg-team0
	
	read -p "Perform service systemctl restart network? " -n 1 -r </dev/tty
	echo
	if [[  $REPLY =~ ^[Yy]$ ]]
	then 
	systemctl restart network
	fi
fi

# DISABLE HUGEPAGES 

echo 'cat /sys/kernel/mm/transparent_hugepage/enabled'
cat /sys/kernel/mm/transparent_hugepage/enabled
echo 'cat /etc/default/grub'
cat /etc/default/grub

read -p "Disable hugpages? " -n 1 -r </dev/tty
echo 
if [[  $REPLY =~ ^[Yy]$ ]]
then
echo 'Perform it according to this tutorial: https://www.thegeekdiary.com/centos-rhel-7-how-to-disable-transparent-huge-pages-thp/'
read -p "Finished ? " -n 1 -r </dev/tty
echo 

fi 

# DISABLE SWAP 

cat /etc/fstab
read -p "Disable SWAP? " -n 1 -r </dev/tty
echo 
if [[  $REPLY =~ ^[Yy]$ ]]
then
echo 'Perform it accoding to this tutorial https://askubuntu.com/questions/214805/how-do-i-disable-swap'
read -p "Finished ? " -n 1 -r </dev/tty

fi 



echo "Installation has been finished. If everything is okay then turn off root login on live machines. Also perform reboot"


