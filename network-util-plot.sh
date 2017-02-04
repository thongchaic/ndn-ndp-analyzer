#!/bin/bash



gnuplot -e <<EOM "
set terminal png enhanced font 'Times,12'; 
set key right ;
set yrange [1:30];
set xlabel 'Consumer';
set xtics 1;
set ylabel 'Runs';
set zlabel 'Utilization (# Pkt)' rotate by 90;
set output 'plot/network-util-1500.png'; 
set xtics font 'Times,16';
set ytics font 'Times,16';
set ztics font 'Times,16';
splot 'netwokutilization-1500.txt' using 1:2:3 with points title 'NDNLP Send',
      'netwokutilization-1500.txt' using 1:2:4 with points title 'NDN-NDP Send',
       'netwokutilization-1500.txt' using 1:2:5 with points title 'NDNLP Nw Process',
      'netwokutilization-1500.txt' using 1:2:6 with points title 'NDN-NDP Nw Process';"

EOM

gnuplot -e <<EOM "
set terminal png enhanced font 'Times,12'; 
set key right ;
set yrange [1:30];
set xlabel 'Consumer';
set xtics 1;
set ylabel 'Runs';
set zlabel 'Utilization (# Pkt)' rotate by 90;
set output 'plot/network-util-9000.png'; 
set xtics font 'Times,16';
set ytics font 'Times,16';
set ztics font 'Times,16';
splot 'netwokutilization-9000.txt' using 1:2:3 with points title 'NDNLP Send',
      'netwokutilization-9000.txt' using 1:2:4 with points title 'NDN-NDP Send',
       'netwokutilization-9000.txt' using 1:2:5 with points title 'NDNLP Nw Process',
      'netwokutilization-9000.txt' using 1:2:6 with points title 'NDN-NDP Nw Process';"

EOM


gnuplot -e <<EOM "
set terminal png enhanced font 'Times,12'; 
set key right ;
set yrange [1:30];
set xlabel 'Consumer';
set xtics 1;
set ylabel 'Runs';
set zlabel 'Utilization (# Pkt)' rotate by 90;
set output 'plot/network-util-diffuse.png'; 
set xtics font 'Times,16';
set ytics font 'Times,16';
set ztics font 'Times,16';
splot 'netwokutilization-SRS.txt' using 1:2:3 with points title 'NDNLP Send',
      'netwokutilization-SRS.txt' using 1:2:4 with points title 'NDN-NDP Send',
       'netwokutilization-SRS.txt' using 1:2:5 with points title 'NDNLP Nw Process',
      'netwokutilization-SRS.txt' using 1:2:6 with points title 'NDN-NDP Nw Process';"

EOM


gnuplot -e <<EOM "
set terminal png enhanced font 'Times,16'; 
set key right ;
set ylabel '# of Pkt';
set xlabel 'MTUs';
set yrange [1:200000];
set boxwidth 0.5;
set style fill solid 1.00 border 0;
set xtics rotate by -45;
set bars 0.5;
set style histogram errorbars gap 2 lw 1;
set output 'plot/network-util.png'; 
plot 'rs-netwokutilization.txt'  using 4:6:xtic(1) with histogram title 'NDNLP' fs pattern 3 , 
     '' using 5:7:xtic(1) with histogram title 'NDN-NDP' fs pattern 2 ;"

EOM


exit 0