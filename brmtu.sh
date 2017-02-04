#!/bin/bash

for bname in $(brctl show | awk '{print $1}')
do
  #echo $bname
  echo ifconfig $bname mtu 9001
done

for bname in $(brctl show | awk '{print $4}' | grep veth)
do
  #echo $bname
  echo ifconfig $bname mtu 9001
done
echo ------------------------------
echo

PYCORE=$(find /tmp/ -maxdepth 1 -type d -name '*pycore*' -print -quit)
echo ++$PYCORE++

speaker-test -t sine -f 1000 &
pid=$!
sleep 0.1s
kill -9 $pid

#echo loop
#for i in {1..30};
#do
#	echo -ne " $i"
	sleep 1
#done 
