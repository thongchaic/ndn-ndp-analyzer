#!/bin/bash
if [ $# -lt 2 ];then 
echo try ./chunkgen byte filename
exit 1
fi
echo  $1 $2 

BASEPATH="./chunks/"
ROW=10000
COL=50
BYTES=$1
FILE=$BASEPATH$2
rm -f $FILE

echo ---generatting $FILE---

 C=65;

 for((i=0;i<$ROW;i++)){

  for((j=0;j<$COL;j++)){
   #printf "\\$(printf '%03o' "$C")"
   printf "\\$(printf '%03o' "$C")" >> $FILE
 }

 printf "\n" >> $FILE
 #echo 
 ((C++))

 if [ $C -gt 90 ]; then
   let C=65
 fi 
# echo "du -k $FILE | cut -f 1i"
 #FSIZE=`du -k $FILE | awk '{print $1}'`
 FSIZE=`stat -c%s "$FILE"`
 #echo  $FSIZE : $BYTES

 if [ $FSIZE -gt $BYTES ]; then
 	#echo "Break;"
 	break 
 fi
 
 
}

echo ---------------**---------------
echo $FILE generated!!! 
