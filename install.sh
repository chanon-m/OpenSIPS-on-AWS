#!/bin/bash

echo "Install opensips configuration file for AWS"

while read -p "Enter Public IP: " public_ip
do
        if [ -n "$public_ip" ]; then
                break
        fi
done

while read -p "Enter Private IP: " private_ip
do
        if [ -n "$private_ip" ]; then
                break
        fi
done

while read -p "Enter Voice Mail IP: " voice_mail
do
        if [ -n "$voice_mail" ]; then
                break
        fi
done

while read -p "Enter SIP Trunk IP: " sip_trunk
do
        if [ -n "$sip_trunk" ]; then
                break
        fi
done

OUTPUT=`perl run.pl $public_ip $private_ip $voice_mail $sip_trunk`
case "$OUTPUT" in
0) echo "Done! Please restart opensips"
   ;;
1) echo "Can not read opensips.cfg!"
   ;;
2) echo "Can not save opensips.cfg!"
   ;;
3) echo "Can not copy opensips.cfg!"
   ;;
4) echo "Can not find /etc/opensips directory!"
   ;;
esac
