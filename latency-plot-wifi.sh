#!/bin/bash

gnuplot -e <<EOM "
set terminal png enhanced font 'Times,16'; 
set key right ;
set yrange [0:800];
set xlabel 'Runs';
set ylabel 'Latency (ms)';
set output 'plot/latency-Wifi1500.png'; 
set xtics font 'Times,16';
set ytics font 'Times,16';

plot 'rs-latency-Wifi1500.txt' using 1:2 with lines notitle, 
	 'rs-latency-Wifi1500.txt' using 1:2:4 with yerrorbars title 'NDNLP', 
	 'rs-latency-Wifi1500.txt' using 1:3 with lines notitle,
	 'rs-latency-Wifi1500.txt' using 1:3:5 with yerrorbars title 'NDN-NDP';"
EOM

gnuplot -e <<EOM "
set terminal png enhanced font 'Times,16'; 
set key right ;
set yrange [0:200];
set xlabel 'Runs';
set ylabel 'Latency (ms)';
set output 'plot/latency-Wifi9000.png'; 
set xtics font 'Times,16';
set ytics font 'Times,16';

plot 'rs-latency-Wifi9000.txt' using 1:2 with lines notitle, 
	 'rs-latency-Wifi9000.txt' using 1:2:4 with yerrorbars title 'NDNLP', 
	 'rs-latency-Wifi9000.txt' using 1:3 with lines notitle,
	 'rs-latency-Wifi9000.txt' using 1:3:5 with yerrorbars title 'NDN-NDP';"
EOM

gnuplot -e <<EOM "
set terminal png enhanced font 'Times,16'; 
set key right ;
set yrange [0:1000];
set xlabel 'Runs';
set ylabel 'Latency (ms)';
set output 'plot/latency-WifiDiffuse.png'; 
set xtics font 'Times,16';
set ytics font 'Times,16';

plot 'rs-latency-WifiDiffuse.txt' using 1:2 with lines notitle, 
	 'rs-latency-WifiDiffuse.txt' using 1:2:4 with yerrorbars title 'NDNLP', 
	 'rs-latency-WifiDiffuse.txt' using 1:3 with lines notitle,
	 'rs-latency-WifiDiffuse.txt' using 1:3:5 with yerrorbars title 'NDN-NDP';"
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
set output 'plot/3dlatency-Wifi9000.png'; 
set xtics font 'Times,16';
set ytics font 'Times,16';
set ztics font 'Times,16';
splot 'latency-Wifi9000.txt' using 1:2:3 with points title 'NDNLP',
      'latency-Wifi9000.txt' using 1:2:4 with points title 'NDN-NDP';"

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
set output 'plot/3dlatency-Wifi1500.png'; 
set xtics font 'Times,16';
set ytics font 'Times,16';
set ztics font 'Times,16';
splot 'latency-Wifi1500.txt' using 1:2:3 with points title 'NDNLP',
      'latency-Wifi1500.txt' using 1:2:4 with points title 'NDN-NDP';"

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
set output 'plot/3dlatency-WifiDiffuse.png'; 
set xtics font 'Times,16';
set ytics font 'Times,16';
set ztics font 'Times,16';
splot 'latency-WifiSRS.txt' using 1:2:3 with points title 'NDNLP',
      'latency-WifiSRS.txt' using 1:2:4 with points title 'NDN-NDP';"

EOM


exit 0