#!/bin/bash

echo $# $0 $1

if [ $# -eq 1 ]
then
NFD=nfd-Wifi$1
NDP=ndp-Wifi$1
OUTPUT=error-rate-Wifi$1.txt
rm -f $OUTPUT
#echo -e "CON\tNFD_INTEREST\tNDP_INTEREST\tNFD_DATA\tNDP_DATA\tNFD_TIMEOUT\tNDP_TIMEOUT\tNFD_MISSING\tNDP_MISSING" >> $OUTPUT

 for c in {1..5}
 do
    #echo ---------CONSUMER$c-----------
    

    for i in {1..30}
    do

      INTEREST=$(cat res/$NFD/$i/ndnperf-Consumer$c | grep ALL | awk '{print $3}')
      DATA=$(cat res/$NFD/$i/ndnperf-Consumer$c | grep ALL | awk '{print $5}')
      TIMEOUT=$(cat res/$NFD/$i/ndnperf-Consumer$c | grep ALL | awk '{print $7}')
      MISSING=$((INTEREST-DATA))
 
      NDP_INTEREST=$(cat res/$NDP/$i/ndnperf-Consumer$c | grep ALL | awk '{print $3}')
      NDP_DATA=$(cat res/$NDP/$i/ndnperf-Consumer$c | grep ALL | awk '{print $5}')
      NDP_TIMEOUT=$(cat res/$NDP/$i/ndnperf-Consumer$c | grep ALL | awk '{print $7}')
      NDP_MISSING=$((NDP_INTEREST-NDP_DATA))

       #echo -e "$TIMEOUT\t$NDP_TIMEOUT" >> $OUTPUT
       #echo -e "$c\t$INTEREST\t$NDP_INTEREST\t$DATA\t$NDP_DATA\t$TIMEOUT\t$NDP_TIMEOUT\t$MISSING\t$NDP_MISSING" #>> $OUTPUT

      if [ "$TIMEOUT" == "" ] && [ "$NDP_TIMEOUT" == "" ]
      then
             echo "x"
        #echo -e "$c\t$TIMEOUT\t$NDP_TIMEOUT" >> $OUTPUT
        #let "NFDRATE=($INTEREST*$TIMEOUT)/100"
        #let "NDPRATE=($NDP_INTEREST*$NDP_TIMEOUT)/100"
        #echo -e "$c\t$NFDRATE\t$NDPRATE" >> $OUTPUT

        #echo -e "$c\t$INTEREST\t$NDP_INTEREST\t$DATA\t$NDP_DATA\t$TIMEOUT\t$NDP_TIMEOUT\t$MISSING\t$NDP_MISSING" #>> $OUTPUT
      else
        echo -e "$c\t$TIMEOUT\t$NDP_TIMEOUT" >> $OUTPUT
      fi
    done
 done

else
  echo ./extract-error-rate-Wifi.sh 9000
fi
