#!/bin/bash
#if [ $# -eq 1 ]
#then
  UIN=$1
  PTH=$(pwd)

  FSIZE="1492 1500 4352 9001 65820"
  
  ifconfig eth0 mtu 1492
  #ndnputchunks /ndn/th/ac/srru/chunk-10kb < /root/ndn/chunks/chunk-10kb
  for i in `echo $FSIZE`
  do
  	 nohup ndnputchunks /A/chunk-$i -f 0 -v -s 8700  < ./chunks/chunk-$i.txt > /dev/null 2>&1 &
  done

  ps aux | grep ndnputchunks

#fivi 