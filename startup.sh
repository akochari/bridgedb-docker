#!/bin/sh

# change to directory of this script
cd $(dirname $0)

#find . org.bridgedb.server.jar
#java -jar -DserverURL="/swagger/" dist/bridgedbServer.jar

# change to directory of this script

pwd
apt install nmap -y
nmap localhost

sed -i "s|SERVER_URL|$SERVER_URL|" /var/www/html/swagger/swagger.json
java -jar BridgeDb-Webservice.jar 8183 > bridgedb.log
