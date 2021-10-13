#!/bin/bash

yum install wget awscli screen jq -y
yum remove java-1.7.0-openjdk -y
yum remove java-1.8.0-openjdk -y
wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm
sudo rpm -Uvh jdk-17_linux-x64_bin.rpm 
yum upgrade -y

sudo hostnamectl set-hostname ${instance_hostname}

adduser --disabled-login minecraft

cd /home/minecraft
mkdir /home/minecraft/current
mkdir /home/minecraft/backups

aws s3 sync s3://${minecraft_data_bucket}} /home/minecraft/current/

cd /home/minecraft/current

wget ${minecraft_version_download_link}

screen

cat >eula.txt<<EULA
#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://account.mojang.com/documents/minecraft_eula).
#Tue Jan 27 21:40:00 UTC 2015
eula=true
EULA

sudo java -Xmx512M -jar server.jar nogui
