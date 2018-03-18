#!/bin/bash

gnuplot -e <<EOM "
set terminal png enhanced font 'Times,16'; 
set key right ;
set ylabel 'Throughput (Kbps)';
set xlabel 'MTUs';
set boxwidth 0.5;
set style fill solid 1.00 border 0;
set xtics rotate by -45;
set bars 0.5;
set style histogram errorbars gap 2 lw 1;
set output 'plot/troughput2.png'; 
plot 'throughput.txt'  using 2:4:xtic(1) with histogram title 'NDNLP' fs pattern 3, 
      'throughput.txt' using 3:5:xtic(1) with histogram title 'NDN-NDP' fs pattern 2 ;"
EOM