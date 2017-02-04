#!/bin/bash
PYCORE=$(find /tmp/ -maxdepth 1 -type d -name '*pycore*' -print -quit)
echo ≈≈≈≈ Consumers and Producer Face Registration ≈≈≈≈
for fid in $(vcmd -c $PYCORE/Producer1 -- nfd-status -f | grep ether | awk '{print $1}')
do
 F=$(echo $fid | cut -c8-)
  vcmd -c $PYCORE/Producer1 -- nfdc register / $F
done

#for fid in $(vcmd -c $PYCORE/Producer2 -- nfd-status -f | grep ether | awk '{print $1}')
#do
# F=$(echo $fid | cut -c8-)
#  vcmd -c $PYCORE/Producer2 -- nfdc register / $F
#done

vcmd -c $PYCORE/Producer1 -- nohup ndnperfserver -p /A/ndnperf -s 0 -f 10000 > /dev/null 2>&1 &
#vcmd -c $PYCORE/Producer2 -- nohup ndnperfserver -p /B/ndnperf -s 0 -f 10000 > /dev/null 2>&1 &

vcmd -c $PYCORE/Producer1 -- nohup ndnpingserver /A > /dev/null 2>&1 &
#vcmd -c $PYCORE/Producer2 --  nohup ndnpingserver /B > /dev/null 2>&1 &

for i in `echo "1 2 3 4 5"`
do

  echo Consumer$i
  for fid in $(vcmd -c $PYCORE/Consumer$i -- nfd-status -f | grep ether | awk '{print $1}')
  do
    F=$(echo $fid | cut -c8-)
     vcmd -c $PYCORE/Consumer$i -- nfdc register / $F
  done
done

echo ∂∂∂∂∂ * Routers FIB Registration * ∂∂∂∂∂

for i in `echo "1 2 3 4 5"`
do
  echo Consumer$i
  for fid in $(vcmd -c $PYCORE/r$i -- nfd-status -f | grep ether | grep eth0 | awk '{print $1}')
  do
    F=$(echo $fid | cut -c8-)
     vcmd -c $PYCORE/r$i -- nfdc register / $F
  done
done
