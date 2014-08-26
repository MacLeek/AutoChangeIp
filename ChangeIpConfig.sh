#!/bin/bash
while [ ! -n "$ip" ]
do
echo -e "\033[32m 请输入你的静态ip: \033[0m" 
read ip 
done

echo -e  "\033[32m 请输入你的网络服务，默认为:WI-FI \033[0m"
read service
if [ ! -n "$service" ]
then
service="WI-FI"
fi

echo '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.
com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
   <key>Label</key>
   <string>com.user.loginscript</string>
   <key>Program</key>
   <string>~/test.sh</string>
   <key>RunAtLoad</key>
   <true/>
</dict>
</plist>' > ~/Library/LaunchAgents/com.user.loginscript.plist

printf 'SSID=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk "/ SSID/ {print substr($0, index($0, $2))}")
if [[ $SSID =~ ^PIAOSHIFU ]]
then
networksetup -setmanual %s %s 255.255.255.0 192.168.1.1
else
networksetup -setdhcp %s
fi' $service $ip $service > ~/changeip.sh 
chmod +x ~/changeip.sh
launchctl load ~/Library/LaunchAgents/com.user.loginscript.plist
