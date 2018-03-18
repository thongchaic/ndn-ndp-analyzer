#!/bin/bash


gnuplot -e <<EOM "
set terminal png enhanced font 'Times,16'; 
set key right ;
set yrange [1:30];
set xlabel 'Consumer';
set xtics 1;
set ylabel 'Payload Size';
set zlabel 'Throughput (Kbps)' rotate by 90;
set output 'plot/3dthroughput-9000.png'; 
set xtics font 'Times,16';
set ytics font 'Times,16';
set ztics font 'Times,16';
splot 'bandwidth-9000.txt' using 1:2:3 with points title 'NDNLP',
      'bandwidth-9000.txt' using 1:2:4 with points title 'NDN-NDP';"

EOM

gnuplot -e <<EOM "
set terminal png enhanced font 'Times,16'; 
set key right ;
set yrange [1:30];
set xlabel 'Consumer';
set xtics 1;
set ylabel 'Payload Size';
set zlabel 'Throughput (Kbps)' rotate by 90;
set output 'plot/3dthroughput-1500.png'; 
set xtics font 'Times,16';
set ytics font 'Times,16';
set ztics font 'Times,16';
splot 'bandwidth-1500.txt' using 1:2:3 with points title 'NDNLP',
      'bandwidth-1500.txt' using 1:2:4 with points title 'NDN-NDP';"

EOM

gnuplot -e <<EOM "
set terminal png enhanced font 'Times,16'; 
set key right ;
set yrange [1:30];
set xlabel 'Consumer';
set xtics 1;
set ylabel 'Payload Size';
set zlabel 'Throughput (Kbps)' rotate by 90;
set output 'plot/3dthroughput-diffise.png'; 
set xtics font 'Times,16';
set ytics font 'Times,16';
set ztics font 'Times,16';
splot 'bandwidth-SRS.txt' using 1:2:3 with points title 'NDNLP',
      'bandwidth-SRS.txt' using 1:2:4 with points title 'NDN-NDP';"

EOM



#plot 'rs-latency-1500.txt' using 1:2 with linespoints;"
# set xlabel '$XLB';
# set ylabel '$YLB';
# set xrange $XRN;
# set yrange $YRN;
#set mxtics 30
# set mytics 1


# plot 'rs-latency-1500.txt' using 1:2 with linespoints title 'NDNLP', 
# 	 'rs-latency-1500.txt' using 1:2:4 with yerrorbars notitle, 
# 	 'rs-latency-1500.txt' using 1:3 with linespoints title 'NDN-NDP',
# 	 'rs-latency-1500.txt' using 1:3:5 with yerrorbars notitle;"

exit 0