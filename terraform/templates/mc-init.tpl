#!/bin/bash

echo "### Setting up ENV Vars ###"
echo export MCRCON_HOST="localhost" >> /etc/profile
echo export MCRCON_PORT="25575" >> /etc/profile
echo export MCRCON_PASS=${minecraft_server_rcon_pass} >> /etc/profile

echo "### Setting up the Libs ###"
yum install wget awscli screen zip unzip jq -y
wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm
sudo rpm -Uvh jdk-17_linux-x64_bin.rpm
yum upgrade -y

echo "### Creating and swapping and setting up user dirs ###"
sudo hostnamectl set-hostname ${instance_hostname}
mkdir /home/minecraft
cd /home/minecraft

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
aws s3 sync s3://${minecraft_data_bucket_id}/${minecraft_world_backup_object} .
aws s3 sync s3://${minecraft_data_bucket_id}/${minecraft_settings_backup_object} .
unzip minecraft-world-backup.zip -d .
cat >server.properties<<SERVER_PROPS
#Minecraft server properties
broadcast-rcon-to-ops=true
view-distance=10
enable-jmx-monitoring=false
server-ip=
resource-pack-prompt=
rcon.port=25575
gamemode=survival
server-port=25565
allow-nether=true
enable-command-block=false
enable-rcon=${minecraft_server_rcon}
sync-chunk-writes=true
enable-query=false
op-permission-level=4
prevent-proxy-connections=false
resource-pack=
entity-broadcast-range-percentage=100
level-name=world
rcon.password=${minecraft_server_rcon_pass}
player-idle-timeout=0
motd=${minecraft_server_motd}
query.port=25565
force-gamemode=false
rate-limit=0
hardcore=${minecraft_server_hardcore_mode}
white-list=${minecraft_server_whitelist}
broadcast-console-to-ops=true
pvp=true
spawn-npcs=true
spawn-animals=true
snooper-enabled=true
difficulty=normal
function-permission-level=2
network-compression-threshold=256
text-filtering-config=
require-resource-pack=false
spawn-monsters=true
max-tick-time=60000
enforce-whitelist=${minecraft_server_whitelist}
use-native-transport=true
max-players=${minecraft_server_max_players}
resource-pack-sha1=
spawn-protection=16
online-mode=true
enable-status=true
allow-flight=false
max-world-size=29999984
SERVER_PROPS

echo "### Firing off server startup command into the running screen emulation ###"
screen -S minecraft -p 0 -X stuff "java -Xmx${minecraft_server_memory}M -jar server.jar nogui^M"

echo "### Setting up Backup script and cron job ###"
cat >backupscript.sh<<BACKUP
#!/bin/bash
export MCRCON_HOST="localhost"
export MCRCON_PORT="25575"
export MCRCON_PASS=${minecraft_server_rcon_pass}
cd /home/minecraft/
./mcrcon -w 1 "say Server is backing up world data. Please be patient." save-off save-all
zip -r minecraft-world-backup.zip world
aws s3 cp minecraft-world-backup.zip s3://${minecraft_data_bucket_id}/${minecraft_world_backup_object}
aws s3 cp whitelist.json s3://${minecraft_data_bucket_id}/${minecraft_settings_backup_object}
./mcrcon -w 1 "say Server world data backup complete. Autosave re-enabled." save-on
rm -rf minecraft-world-backup.zip
BACKUP
chmod a+x backupscript.sh
echo "root" >/etc/cron.allow
touch /var/spool/cron/root /usr/bin/crontab /var/spool/cron/root
echo "0 0 * * * /home/minecraft/backupscript.sh" >> /var/spool/cron/root

echo "### Setup mcrcon ###"
mkdir /home/tools
cd /home/tools
wget https://github.com/Tiiffi/mcrcon/releases/download/v0.7.1/mcrcon-0.7.1-linux-x86-64.tar.gz
tar -C /home/minecraft -xvf mcrcon-0.7.1-linux-x86-64.tar.gz mcrcon-0.7.1-linux-x86-64/mcrcon --strip-components=1
