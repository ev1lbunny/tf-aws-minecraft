#!/bin/bash

yum install java-1.8.0 wget awscli jq -y
yum remove java-1.7.0-openjdk -y
yum upgrade -y

sudo hostnamectl set-hostname ${instance_hostname}

adduser --disabled-login minecraft

cd /home/minecraft
mkdir /home/minecraft/current
mkdir /home/minecraft/backups

aws s3 sync s3://${minecraft_data_bucket}} /home/minecraft/current/

cd /home/minecraft/current



wget "https://launcher.mojang.com/v1/objects/a16d67e5807f57fc4e550299cf20226194497dc2/server.jar"

sudo java -Xmx1024M -jar server.jar nogui 

