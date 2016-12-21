#!/bin/sh
chk=`cat .chk`
if [ "$chk" = 0 ]; then
net=`ping -c 3 8.8.8.8 | grep loss | awk '{print $6}' | sed s/%//g`
	if [ "$net" = 0 ]; then
	exit 0
	else
		if [ "$net" = 100 ]; then
		date "+%H:%M:%S" > .chk
		exit 0
		else
		exit 0
		fi
	fi
else
	if [ "$chk" = 1 ]; then
	ip=`curl -s icanhazip.com`
		if [ -z "$ip" ]; then
		echo 1 > .chk
		exit 0
		else
		up=`uptime | awk '{print $2 $3 $4}'`
		local=`/sbin/ifconfig | grep "inet addr:" | grep -v "127.0.0.1" | awk '{ print $2 }'`
		time=`date "+%H:%M:%S %d-%m-%Y"`
		curl -s \
  		-F "token=[TOKEN here]" \
  		-F "user=[USER here]" \
  		-F "message=I am online at external ip:$ip & local $local  @ $time & $up" \
  		https://api.pushover.net/1/messages.json
		echo 0 > .chk
		fi
	else
		net=`ping -c 3 8.8.8.8 | grep loss | awk '{print $6}' | sed s/%//g`
		if [ "$net" = 0 ]; then
		ip=`curl -s icanhazip.com`
                up=`uptime | awk '{print $2 $3 $4}'`
                local=`/sbin/ifconfig | grep "inet addr:" | grep -v "127.0.0.1" | awk '{ print $2 }'`
                time=`date "+%H:%M:%S %d-%m-%Y"`
                curl -s \
		-F "token=[TOKEN here]" \
                -F "user=[USER here]" \
		-F "priority=0" \
                -F "message=I was offline since $chk Now I am online at external ip:$ip & local $local  @ $time & $up" \
                https://api.pushover.net/1/messages.json
                echo 0 > .chk
		else
		exit 0
		fi
	fi	
fi
