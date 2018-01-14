#!/bin/bash

#cron7 - kaczka sql

DATE=`date +%d-%m-%Y`


if [ ! -d "[Path]/$DATE" ];
        then mkdir [Path]/$DATE
fi

N=0
for I in `cat plik.txt`
do
    TAB[$N]=$I 
    N=$[N+1]
done    

LENNAME=${#TAB[@]}	

    K=0;
    Q=1;

	while [ $K -lt $LENNAME ]; do
		ssh -o ConnectTimeout=60 -o BatchMode=yes -o StrictHostKeyChecking=no [Host] 'mysqldump -u '${TAB[K]}' -p'"\"${TAB[Q]}\"" ${TAB[K]}  > [Path]/$DATE/${TAB[$K]}.sql	
        
        sleep 120
        K=$[K+2]
        Q=$[Q+2]
	done


sendEmail -f [Email] -t [Email] -u Cron -m Cron sql zakonczyl dzialanie -s [Email]:587 -xu [Email] -xp [Pass]
