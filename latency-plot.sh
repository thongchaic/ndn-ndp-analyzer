#!/bin/bash

gnuplot -e <<EOM "
set terminal png enhanced font 'Times,16'; 
set key right ;
set yrange [0:800];
set xlabel 'Runs';
set ylabel 'Latency (ms)';
set output 'plot/latency-1500.png'; 
set xtics font 'Times,16';
set ytics font 'Times,16';

plot 'rs-latency-1500.txt' using 1:2 with lines notitle, 
	 'rs-latency-1500.txt' using 1:2:4 with yerrorbars title 'NDNLP', 
	 'rs-latency-1500.txt' using 1:3 with lines notitle,
	 'rs-latency-1500.txt' using 1:3:5 with yerrorbars title 'NDN-NDP';"
EOM

gnuplot -e <<EOM "
set terminal png enhanced font 'Times,16'; 
set key right ;
set yrange [0:200];
set xlabel 'Runs';
set ylabel 'Latency (ms)';
set output 'plot/latency-9000.png'; 
set xtics font 'Times,16';
set ytics font 'Times,16';

plot 'rs-latency-9000.txt' using 1:2 with lines notitle, 
	 'rs-latency-9000.txt' using 1:2:4 with yerrorbars title 'NDNLP', 
	 'rs-latency-9000.txt' using 1:3 with lines notitle,
	 'rs-latency-9000.txt' using 1:3:5 with yerrorbars title 'NDN-NDP';"
EOM

gnuplot -e <<EOM "
set terminal png enhanced font 'Times,16'; 
set key right ;
set yrange [0:1000];
set xlabel 'Runs';
set ylabel 'Latency (ms)';
set output 'plot/latency-diffuse.png'; 
set xtics font 'Times,16';
set ytics font 'Times,16';

plot 'rs-latency-diffuse.txt' using 1:2 with lines notitle, 
	 'rs-latency-diffuse.txt' using 1:2:4 with yerrorbars title 'NDNLP', 
	 'rs-latency-diffuse.txt' using 1:3 with lines notitle,
	 'rs-latency-diffuse.txt' using 1:3:5 with yerrorbars title 'NDN-NDP';"
EOM


gnuplot -e <<EOM "
set terminal png enhanced font 'Times,16'; 
set key right ;
set yrange [1:30];
set zrange [0:500];
set xlabel 'Consumer';
set xtics 1;
set ylabel 'Runs';
set zlabel 'Latency (ms)' rotate by 90;
set output 'plot/3dlatency-9000.png'; 
set xtics font 'Times,16';
set ytics font 'Times,16';
set ztics font 'Times,16';
splot 'latency-9000.txt' using 1:2:3 with points title 'NDNLP',
      'latency-9000.txt' using 1:2:4 with points title 'NDN-NDP';"

EOM

gnuplot -e <<EOM "
set terminal png enhanced font 'Times,16'; 
set key right ;
set yrange [1:30];
set zrange [0:500];
set xlabel 'Consumer';
set xtics 1;
set ylabel 'Runs';
set zlabel 'Latency (ms)' rotate by 90;
set output 'plot/3dlatency-1500.png'; 
set xtics font 'Times,16';
set ytics font 'Times,16';
set ztics font 'Times,16';
splot 'latency-1500.txt' using 1:2:3 with points title 'NDNLP',
      'latency-1500.txt' using 1:2:4 with points title 'NDN-NDP';"

EOM


gnuplot -e <<EOM "
set terminal png enhanced font 'Times,16'; 
set key right ;
set yrange [1:30];
set zrange [0:500];
set xlabel 'Consumer';
set xtics 1;
set ylabel 'Runs';
set zlabel 'Latency (ms)' rotate by 90;
set output 'plot/3dlatency-SRS.png'; 
set xtics font 'Times,16';
set ytics font 'Times,16';
set ztics font 'Times,16';
splot 'latency-SRS.txt' using 1:2:3 with points title 'NDNLP',
      'latency-SRS.txt' using 1:2:4 with points title 'NDN-NDP';"

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