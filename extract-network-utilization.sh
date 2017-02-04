#!/bin/bash

echo $# $0 $1

if [ $# -eq 1 ]
then
NFD=nfd-$1
NDP=ndp-$1
OUTPUT="netwokutilization-$1.txt"
rm -f $OUTPUT
 for c in {1..5}
 do
    #echo ---------CONSUMER$c-----------
    
    echo -e "#CON\tNFD_INTEREST\tNDP_INTEREST\tNFD_DATA\tNDP_DATA" >> $OUTPUT

    for i in {1..30}
    do

      INDATA=$(cat res/$NFD/$i/ndndump-Consumer$c | grep DATA | wc -l | xargs)
      INLPFR=$(cat res/$NFD/$i/ndndump-Consumer$c | grep NDNLPv2-FRAGMENT | wc -l | xargs)
      INUNFR=$(cat res/$NFD/$i/ndndump-Consumer$c | grep UNKNOWN-NETWORK-PACKET | wc -l | xargs)

      ININTEREST=$(cat res/$NFD/$i/ndndump-Consumer$c | grep INTEREST | wc -l | xargs)


      NDPDATA=$(cat res/$NDP/$i/ndndump-Consumer$c | grep DATA | wc -l | xargs)
      INNDPLPFR=$(cat res/$NDP/$i/ndndump-Consumer$c | grep NDNLPv2-FRAGMENT | wc -l | xargs)
      INNDPUNFR=$(cat res/$NDP/$i/ndndump-Consumer$c | grep UNKNOWN-NETWORK-PACKET | wc -l | xargs)

      let "INDATA=INDATA+INLPFR+INUNFR";
      let "NDPDATA=NDPDATA+INNDPLPFR+INNDPUNFR";

      NDPINTEREST=$(cat res/$NDP/$i/ndndump-Consumer$c | grep INTEREST | wc -l | xargs)

      echo -e "$c\t$i\t$ININTEREST\t$NDPINTEREST\t$INDATA\t$NDPDATA" >> $OUTPUT

    done
 done

else
  echo "./extract-pkt-in.sh 9000"
fi