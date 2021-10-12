#!/bin/bash

yum install java-1.8.0 wget awscli screen jq -y
yum remove java-1.7.0-openjdk -y
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

sudo java -Xmx1024M -jar server.jar nogui
