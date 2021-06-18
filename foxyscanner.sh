#!/bin/bash

# ./foxyscanner.sh <ip_address>

source src/banner.sh

echo "[!] For use this tool is recommended to have installed xclip"
echo -e "[+] Starting...\n"
sleep 2.5

if [ $1 ]; then
	ip_address=$1
	for port in $(seq 1 65525); do
		timeout 1 bash -c "echo '' > /dev/tcp/$ip_address/$port" 2>/dev/null && echo -e "\n [!] Discovered open port: $port \n" && echo "$port" >> ports.txt &
		echo -en "\rPort Number: $port";
		sleep 0.06
	done; wait
	cat ports.txt | tr '\n' ',' | xclip -sel clip
	echo "\n[+] Ports copied to clipboard successfully! =)"
	sleep 1
	echo "[+] Good Hacking! ;)"
	exit 0
else
	echo -e "\n[*] Use: ./foxyscanner.sh <ip_address>\n"
	exit 1
fi
