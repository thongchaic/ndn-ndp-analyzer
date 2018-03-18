#!/bin/bash


echo $# $0 $1

if [ $# -eq 1 ]
then

NFD=nfd-$1
NDP=ndp-$1
OUTFILE=status-$1.txt
rm -f $OUTFILE  
  for c in {1..5}
  do
    #echo ---------CONSUMER$c-----------
    #echo -e "#CON\tRUN\tNFD\tNDP" >> $OUTFILE
    NFD_SUM=0
    NDP_SUM=0

    for i in {1..30}
    do

		IINNFD=$(cat res/$NFD/$i/nfd-status-Consumer$c | grep 01:00:5e:00:17:aa | awk '{print $4}')
		IINNDP=$(cat res/$NDP/$i/nfd-status-Consumer$c | grep 01:00:5e:00:17:aa | awk '{print $4}')

		IDNNFD=$(cat res/$NFD/$i/nfd-status-Consumer$c | grep 01:00:5e:00:17:aa | awk '{print $5}')
		IDNNDP=$(cat res/$NDP/$i/nfd-status-Consumer$c | grep 01:00:5e:00:17:aa | awk '{print $5}')

		OINFD=$(cat res/$NFD/$i/nfd-status-Consumer$c | grep 01:00:5e:00:17:aa | awk '{print $8}')
		OINDP=$(cat res/$NDP/$i/nfd-status-Consumer$c | grep 01:00:5e:00:17:aa | awk '{print $8}')

		ODNFD=$(cat res/$NFD/$i/nfd-status-Consumer$c | grep 01:00:5e:00:17:aa | awk '{print $9}')
		ODNDP=$(cat res/$NDP/$i/nfd-status-Consumer$c | grep 01:00:5e:00:17:aa | awk '{print $9}')

      #echo $PNFD
      echo  -e  "$IINNFD\t$IINNDP\t$IDNNFD\t$IDNNDP\t$OINFD\t$OINDP\t$ODNFD\t$ODNDP" >> $OUTFILE

      #NFD_SUM=$(expr $PNFD + $NFD_SUM)
      #NDP_SUM=$(expr $PNDP + $NDP_SUM)
     # NDP_SUM=(($))
     # echo $c     $i         $PNFD    $PNDP  #$NFD_SUM     $NDP_SUM  #

    done
    echo ====SUMMARY====
  done

else
  echo ./extract-status.sh 1500
fi