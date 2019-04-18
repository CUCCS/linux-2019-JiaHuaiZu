#!/bin/bash
#web Processing

function usage(){
	echo " IMproved 1.0 (2019 April 12) "
	echo " usage: bash web visit processing "
	echo " Arguments: "
	echo " -a :top100 hostname and time"
	echo " -b :top100 ip and time"
	echo " -c :top100 url"
	echo " -d :different status code time and percent"
	echo " -e :4XX status code top10 url and time"
	echo " -f [url]:top100 hostname of this url "
}
function process(){
	if [ "$1" == "-a" ];then
		grep -oP '^(\w+\.)+[A_Za-z]+' web_log.tsv | sort -n | uniq -c | sort -nr -k1 | head -100
	elif [ "$1" == "-b" ];then
		grep -oP '(\d+\.){3}\d+\s' web_log.tsv | sort -nr | uniq -c | sort -nr -k1 | head -100
	elif [ "$1" == "-c" ];then
		grep -oP '(\/[^\s]+)+' web_log.tsv | sort -n | uniq -c | sort -nr -k1 | head -100
	elif [ "$1" == "-d" ];then
		grep -oP '\s+\d{3}\s+(?=\d+)' web_log.tsv | sort | uniq -c | sort -nr -k1 | awk '{array[$2]=$1; sum+=$1} END { for (i in array) printf "%-20s %-15d %6.6f%%\n", i, array[i], array[i]/sum*100}'
	elif [ "$1" == "-e" ];then
		grep -oP '\s+4\d{2}\s+(?=\d+)' web_log.tsv | sort -u | xargs -i sh -c "grep -P '\s+{}(?=\d+)' web_log.tsv | awk '{printf \"%s %d \n\",\$5,\$6}' | sort | uniq -c | sort -nr -k1 | head -10"
	elif [ "$1" == "-f" ] && [ $# == 2 ];then
		awk -F '\t' '{if($5=="'$2'")sum[$2]+=1} END {for(i in sum){print sum[i],i}}' web_log.tsv | sort -n -r -k 1 | head -n 100	
	else
		usage
	fi
}
process $1 $2
