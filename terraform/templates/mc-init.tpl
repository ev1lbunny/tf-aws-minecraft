#!/bin/bash

echo "### Setting up the Libs ###"
yum install wget awscli screen jq -y
wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm
sudo rpm -Uvh jdk-17_linux-x64_bin.rpm
yum upgrade -y

echo "### Creating and swapping and setting up user dirs ###"
sudo hostnamectl set-hostname ${instance_hostname}
mkdir /home/minecraft && cd /home/minecraft

echo "### Setting up screen session to leave open ###"
screen -d -m -S minecraft

echo "### Downloading Minecraft server files and setting up eula accetpance file ###"
wget ${minecraft_version_download_link}
cat >eula.txt<<EULA
#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://account.mojang.com/documents/minecraft_eula).
#Tue Jan 27 21:40:00 UTC 2015
eula=true
EULA

echo "### Getting any world / game data from s3 bucket before starting server ###"
aws s3 sync s3://${minecraft_data_bucket_id}/minecraft/minecraft_server_data/ .

echo "### Firing off server startup command into the running screen emulation ###"
screen -S minecraft -p 0 -X stuff "java -Xmx512M -jar server.jar nogui^M"