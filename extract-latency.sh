#!/bin/bash

echo $# $0 $1

if [ $# -eq 1 ]
then
NFD=nfd-$1
NDP=ndp-$1
OUTFILE=latency-$1.txt 
rm -f $OUTFILE
 for c in {1..5}
 do

    #echo ---------CONSUMER$c-----------
    echo -e "#CON\tRUN\tNFD\tNDP" >> $OUTFILE

    for i in {1..30}
    do

      NFDL="";
      for lt in $(cat res/$NFD/$i/ndnperf-Consumer$c | grep RES | awk '{print $16}')
      do
        NFDL="$NFDL $lt";
      done 

      NDPL="";
      for lt in $(cat res/$NDP/$i/ndnperf-Consumer$c | grep RES | awk '{print $16}')
      do
        NDPL="$NDPL $lt";
      done 

      # echo "NFD: $NFDL";
      # echo "NDP: $NDPL";

      for j in {1..30}
      do
        FL=`echo $NFDL | awk -v M=$j '{print $M}'`;
        SL=`echo $NDPL | awk -v M=$j '{print $M}'`;
        if [ "$FL" == "" ] || [ "$FL" == "-" ]
        then
          FL=0
        fi
        if [ "$SL" == "" ] || [ "$SL" == "-" ]
        then
          SL=0
        fi

        echo $SL $FL

        ((SL=SL/1000))

        ((FL=FL/1000))

        echo -e "$c\t$i\t$FL\t$SL" >> $OUTFILE
      done

      # for latency in $(ls -l $fd | grep ndnperf-Consumer$c | awk '{print $9}')
      # do
      #   echo $latency
      # done
    done
   # for fd in $(ls -l $DIR/* -d | sort | awk '{print $9}')
   # do

   #   ls -l $fd | grep ndnperf-Consumer$c | awk '{print $9}'
   #   #for file in $(ls -l $fd | grep ndnperf-Consumer$c | awk '{print $9}')
   #   #do 
   #     #| grep RES | awk '{print $16}
   #     #cat $fd/$file | grep RES | awk '{print $16}'
   #   #done
   # done
 done

else
  echo ./extract-latency.sh 9000
fi