#!bin/bash
#data processing

function process(){
	ages=$(awk -F '\t' '{print $6}' worldcupplayerinfo.tsv)	
	positions=$(awk -F '\t' '{print $5}' worldcupplayerinfo.tsv)
	names=$( awk -F '\t' '{print length($9)}' worldcupplayerinfo.tsv)
	total=0
	age_down_20=0
	age_between_20_30=0
	age_up_30=0
	oldest=0
	oldestname=''
	youngest=100
	youngestname=''
	max=0
	min=100
	maxname=''
	minname=''
	for age in $ages
	do
		if [ "$age" != 'Age' ] ;then
			total=$(( $total+1 ))
			if [ "$age" -lt 20 ] ;then
				age_down_20=$(( $age_down_20+1 ))	
			elif [ "$age" -ge 20 ]&&[ "$age" -le 30 ] ;then
				age_between_20_30=$(( $age_between_20_30+1 ))
			else
				age_up_30=$(( $age_up_30+1 ))		
			fi
			if [ "$age" -gt "$oldest" ] ;then 
				oldest=$age
				oldestname=$(awk -F '\t' 'NR=='$[$total +1]' {print $9}' worldcupplayerinfo.tsv)
			elif [ $age -lt $youngest ];then 
				youngest=$age
				youngestname=$(awk -F '\t' 'NR=='$[$total +1]' {print $9}' worldcupplayerinfo.tsv)
			fi
		fi
	done
	declare -A num
	for position in $positions
	do
		if [ "$position" != 'Position' ] ;then 
			if [[ !${num[$position]} ]];then	
				let num[$position]+=1
			else
				num[$position]=0
			fi
		fi	
	done
	count=0
	for name in $names
	do 	
		count=$[$count + 1]	
		if [[  $name -gt $max ]];then
			max=$name
			maxname=$(sed -n $count'p' 'worldcupplayerinfo.tsv'|awk -F '\t' '{print $9}')
		elif [[  $name -lt $min ]];then
			min=$name
			minname=$(sed -n $count'p' 'worldcupplayerinfo.tsv'|awk -F '\t' '{print $9}')
		fi			
	done	
	per_down_20=$(awk 'BEGIN{printf "%.2f",'$age_down_20*100/$total'}')
	per_between_20_30=$(awk 'BEGIN{printf "%.2f",'$age_between_20_30*100/$total'}')
	per_up_30=$(awk 'BEGIN{printf "%.2f",'$age_up_30*100/$total'}')
	echo 'The number and proportion of people under 20:'$age_down_20' '$per_down_20'%'
	echo 'The number and proportion of people between 20 to 30:'$age_between_20_30' '$per_between_20_30'%'
	echo 'The number and proportion of people above 30:'$age_up_30' '$per_up_30'%'
	echo ''
	echo 'Position Proportion'
	for n in ${!num[@]}
	do
		echo "$n : ${num[$n]}" $(awk 'BEGIN{printf "%.2f",'${num[$n]}*100/$total'}')'%'
	done
	echo ''
	echo 'The shortest name is' $minname 'length' $min
	echo 'The longest name is' $maxname 'length' $max
	echo ''
	echo 'The youngest player is' $youngestname 'age' $youngest
	echo 'The oldest player is' $oldestname 'age' $oldest
}
process
