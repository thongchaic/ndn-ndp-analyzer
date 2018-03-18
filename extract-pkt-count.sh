#!/bin/bash

echo $# $0 $1

if [ $# -eq 1 ]
then

NFD=nfd-$1
NDP=ndp-$1
OUTFILE=pkt-count-$1.txt
rm -f $OUTFILE  
  for c in {1..5}
  do
    #echo ---------CONSUMER$c-----------
    #echo -e "#CON\tRUN\tNFD\tNDP" >> $OUTFILE
    NFD_SUM=0
    NDP_SUM=0

    for i in {1..30}
    do

      PNFD=$(cat res/$NFD/$i/ndnperf-Consumer$c | wc -l)
      PNDP=$(cat res/$NDP/$i/ndnperf-Consumer$c | wc -l)

      NFD_SUM=$(expr $PNFD + $NFD_SUM)
      NDP_SUM=$(expr $PNDP + $NDP_SUM)
     # NDP_SUM=(($))
      echo $c     $i     $PNFD    $PNDP     $NFD_SUM     $NDP_SUM
      #echo -e "$c\t$i\t$PNFD\t$PNDP" >> $OUTFILE

      # echo "NFD: $NFDL";
      # echo "NDP: $NDPL";

    #   for j in {1..30}
    #   do
    #     FL=`echo $NFDL | awk -v M=$j '{print $M}'`;
    #     SL=`echo $NDPL | awk -v M=$j '{print $M}'`;
    #     if [ "$FL" == "" ]
    #     then
    #       FL="0";
    #     fi
    #     if [ "$SL" == "" ]
    #     then
    #       SL=0;
    #     fi
    #      echo "$c\t$i\t$FL\t$SL"
    #    # echo -e "$c\t$i\t$FL\t$SL" >> $OUTFILE
      
    #   done

    #   # for latency in $(ls -l $fd | grep ndnperf-Consumer$c | awk '{print $9}')
    #   # do
    #   #   echo $latency
    #   # done
    # done
   # for fd in $(ls -l $DIR/* -d | sort | awk '{print $9}')
   # do

   #   ls -l $fd | grep ndnperf-Consumer$c | awk '{print $9}'
   #   #for file in $(ls -l $fd | grep ndnperf-Consumer$c | awk '{print $9}')
   #   #do 
   #     #| grep RES | awk '{print $16}
   #     #cat $fd/$file | grep RES | awk '{print $16}'
   #   #done
    done
    echo ====SUMMARY====
    echo $c     30     $NFD_SUM     $NDP_SUM
    echo -e "$c\t30\t$NFD_SUM\t$NDP_SUM" >> $OUTFILE
  done

else
  echo ./extract-bandwidth.sh 9000
fi