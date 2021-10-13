#!/bin/bash

### Setting up the Libs ###
yum install wget awscli screen jq -y
wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm
sudo rpm -Uvh jdk-17_linux-x64_bin.rpm 
yum upgrade -y

### Creating and swapping and setting up user dirs ###
sudo hostnamectl set-hostname ${instance_hostname}
sudo adduser minecraft
sudo -i -u minecraft
cd /home/minecraft
mkdir /home/minecraft/current
mkdir /home/minecraft/backups

### Setting up screen session to leave open ###
screen -d -m -S minecraft
aws s3 sync s3://${minecraft_data_bucket_id} ./backups
wget ${minecraft_version_download_link}

cat >eula.txt<<EULA
#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://account.mojang.com/documents/minecraft_eula).
#Tue Jan 27 21:40:00 UTC 2015
eula=true
EULA

screen -S minecraft -p 0 -X stuff "java -Xmx512M -jar server.jar nogui^M"
