#!/bin/bash
PYCORE=$(find /tmp/ -maxdepth 1 -type d -name '*pycore*' -print -quit)
#RMTUs="1492 1500 4352 9001 65820"

RMTUs="9001 9001 9001 9001 9001"
CONsMTU="9001 9001 9001 9001 9001"

echo ==Init MTU==
echo   ----Producer
vcmd -c $PYCORE/Producer1 -- ifconfig eth0 0.0.0.0
vcmd -c $PYCORE/Producer1 -- ifconfig eth0 mtu 9001 #Producer1's MTU
echo ==Consumer1==
vcmd -c $PYCORE/Producer1 -- ifconfig eth0

#vcmd -c $PYCORE/Producer2 -- ifconfig eth0 0.0.0.0
#vcmd -c $PYCORE/Producer2 -- ifconfig eth0 mtu 9001 #Producer2's MTU
#echo Consumer2
#vcmd -c $PYCORE/Producer2 -- ifconfig eth0

echo   ----Router----
I=1
for mtu in `echo $RMTUs`
do
  echo Setting r$I MTU of $mtu
  for eth in $(vcmd -c $PYCORE/r$I -- ifconfig | grep eth | awk '{print $1}')
  do
   vcmd -c $PYCORE/r$I -- ifconfig $eth 0.0.0.0
   vcmd -c $PYCORE/r$I -- ifconfig $eth mtu $mtu
   vcmd -c $PYCORE/r$I -- ifconfig $eth
  done
  ((I++))
done

vcmd -c $PYCORE/r1 -- ifconfig eth0 mtu 9001
vcmd -c $PYCORE/r5 -- ifconfig eth1 mtu 9001

echo   ----Consumer----
I=1
for mtu in `echo $CONsMTU`
do
  vcmd -c $PYCORE/Consumer$I -- ifconfig eth0 0.0.0.0
  vcmd -c $PYCORE/Consumer$I -- ifconfig eth0 mtu $mtu
  vcmd -c $PYCORE/Consumer$I -- ifconfig eth0
  ((I++))
done

echo Expand bridge MTU
for bname in $(brctl show | awk '{print $1}')
do
  echo $bname
   ifconfig $bname mtu 60000
done

for bname in $(brctl show | awk '{print $4}' | grep veth)
do
  echo $bname
   ifconfig $bname mtu 60000
done

echo
echo ^^^^START NFD^^^^

 vcmd -c $PYCORE/Producer1 -- nfd-stop > /dev/null
 sleep 5
 #vcmd -c $PYCORE/Producer2 -- nfd-stop > /dev/null
 #sleep 5
 vcmd -c $PYCORE/Producer1 -- nfd-start > /dev/null
 sleep 5
 #vcmd -c $PYCORE/Producer2 -- nfd-start > /dev/null
 #sleep 5
for dev in $(echo 1 2 3 4 5)
do
   vcmd -c $PYCORE/r$dev -- nfd-stop > /dev/null
   sleep 5
   vcmd -c $PYCORE/r$dev -- nfd-start > /dev/null
   sleep 5
   vcmd -c $PYCORE/Consumer$dev -- nfd-stop > /dev/null
   sleep 5
   vcmd -c $PYCORE/Consumer$dev -- nfd-start > /dev/null
  sleep 5
done

echo *====*Success*=====*

#for fid in $(vcmd -c $PYCORE/Producer1 -- nfd-status -f | grep ether | awk '{print $1}')
#do
# F=$(echo $fid | cut -c8-)
# echo EtherFace = $F
#done
