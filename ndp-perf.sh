#!/bin/bash
PYCORE=$(find /tmp/ -maxdepth 1 -type d -name '*pycore*' -print -quit)
echo X=$# $0 $1
if [ $# -eq 1 ]
then
  UIN=$1
  PTH=$(pwd)

	for TT in {1..35};
	do

	  	OUTPATH=$PTH/$UIN/$TT

	  	rm -rf $OUTPATH
	  	mkdir -p $OUTPATH
	    for i in `echo "1 2 3 4 5"`
	    do
	      gnome-terminal -x $PTH/ndp-perf.sh Consumer$i $OUTPATH
	    done

	    for ZZ in {1..10};
		do
			echo -ne "." 
			sleep 1
		done
		echo 
	    
	    tail -f $OUTPATH/ndnperf-Consumer1 | while read LINE
		do
			echo $LINE
		    if [[ "${LINE}" == *"ALL"* ]] 
		    then
		    	echo "Break - "
		     	pkill -P $$ tail
		    elif [[ "${LINE}" == *"FAILURE"* ]] 
		    then
		    	echo "Break - "
		     	pkill -P $$ tail
		    fi
		done

		echo "Preparing a new experiment"
		for ZZ in {1..60};
		do
			echo -ne "." 
			sleep 1
		done
		echo 

	done
	#BEEP
	speaker-test -t sine -f 1000 &
	pid=$!
	sleep 0.5s
	kill -9 $pid

elif [ $# -eq 2 ]
then

 CONSUMER=$1
 OUTPATH=$2
 echo ndnperf on $CONSUMER
 echo $CONSUMER [ndnperf -n 30 -p /A/ndnperf to res-perf-$CONSUMER]
 vcmd -c $PYCORE/$CONSUMER -- ndnperf -n 30 -p /A/ndnperf >  $OUTPATH/ndnperf-$CONSUMER &
 echo $CONSUMER [ndndump to $OUTPATH/res-dump-$CONSUMER]
 vcmd -c $PYCORE/$CONSUMER -- ndndump > $OUTPATH/ndndump-$CONSUMER &

	 #watch 
	for ZZ in {1..10};
	do
		echo -ne "." 
		sleep 1
	done

	tail -f $OUTPATH/ndnperf-$CONSUMER | while read LOGLINE
	do
		echo $LOGLINE
	    if [[ "${LOGLINE}" == *"ALL"* ]] 
	    then
	     	echo $CONSUMER [nfd-status to $OUTPATH/nfd-status-$CONSUMER]
	 		vcmd -c $PYCORE/$CONSUMER -- nfd-status > $OUTPATH/nfd-status-$CONSUMER
	 		echo pkill -P $$ tail
	    	pkill -P $$ tail
	    elif [[ "${LOGLINE}" == *"FAILURE"* ]] 
	    then
	    	echo FAILURE : $CONSUMER [nfd-status to $OUTPATH/nfd-status-$CONSUMER]
	 		vcmd -c $PYCORE/$CONSUMER -- nfd-status > $OUTPATH/nfd-status-$CONSUMER
	    	pkill -P $$ tail
	    fi
	done

echo Finished...!
sleep 10
exit 0
else
	echo nfd-perf [OutFolder: res/nfd]
fi
exit 0
