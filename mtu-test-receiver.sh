#!/bin/bash

MTU=1500
INF="eth0"
EXPR="NFD"
FOLD="./res-mtu"
MTUs="127 1492 1500 4352 9001 65820"
GETCH="1492 1500 4352 9001 65820"
for i in `echo $MTUs`
do
	echo "-----------------------------"
	OUTFILE="$FOLD/$EXPR-res-mtu-$i.txt"
	echo ifconfig $INF mtu $i
	
	for k in `echo $GETCH`
	do

		for j in {1..3};
		do	
			#
			echo  [$j] ndncatchunks /A/chunk-$k  to $OUTFILE
			#res=$(ndncatchunks /A/chunk-$i)
			EXST=$?
			if [ "$EXST" == "0" ];
			then
				echo "$j $k OK" #>> $OUTFILE
			else 
				echo "$j $k ERR" #>> $OUTFILE
			fi

			sleep 1
		done

	done

	sleep 1;
done