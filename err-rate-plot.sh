#!/bin/bash

# gnuplot -e <<EOM "
# set terminal png enhanced font 'Times,16'; 
# set key right ;
# set yrange [0:800];
# set xlabel 'Runs';
# set ylabel 'Error Rate(%)';
# set output 'plot/error-rate-1500.png'; 
# set xtics font 'Times,16';
# set ytics font 'Times,16';

# plot 'error-rate-1500.txt' using 0:1 with linespoints title 'NDNLP', 
# 	 'error-rate-1500.txt' using 0:2 with linespoints title 'NDN-NDP';"
# EOM


# gnuplot -e <<EOM "
# set terminal png enhanced font 'Times,16'; 
# set key right ;
# set yrange [0:800];
# set xlabel 'Runs';
# set ylabel 'Latency (ms)';
# set output 'plot/error-rate-9000.png'; 
# set xtics font 'Times,16';
# set ytics font 'Times,16';

# plot 'error-rate-9000.txt' using 0:1 with linespoints title 'NDNLP', 
# 	 'error-rate-9000.txt' using 0:2 with linespoints title 'NDN-NDP';"
# EOM

# gnuplot -e <<EOM "
# set terminal png enhanced font 'Times,16'; 
# set key right ;
# set yrange [0:800];
# set xlabel 'Runs';
# set ylabel 'Latency (ms)';
# set output 'plot/error-rate-diffuse.png'; 
# set xtics font 'Times,16';
# set ytics font 'Times,16';

# plot 'error-rate-SRS.txt' using 0:1 with linespoints title 'NDNLP', 
# 	 'error-rate-SRS.txt' using 0:2 with linespoints title 'NDN-NDP';"
# EOM

#___histogram____


gnuplot -e <<EOM "
set terminal png enhanced font 'Times,16'; 
set key right ;
set ylabel '# of Error';
set xlabel 'MTUs';
set yrange [0:600];
set boxwidth 0.5;
set style fill solid 1.00 border 0;
set xtics rotate by -45;
set bars 0.5;
set style histogram errorbars gap 2 lw 1;
set output 'plot/error-rate.png'; 
plot 'rs-err.txt'  using 3:5:xtic(2) with histogram title 'NDNLP' fs pattern 3, 
      '' using 4:6:xtic(2) with histogram title 'NDN-NDP' fs pattern 2 ;"

EOM

gnuplot -e <<EOM "
set terminal png enhanced font 'Times,16'; 
set key right ;
set ylabel '# of Error';
set xlabel 'MTUs';
set yrange [0:600];
set boxwidth 0.5;
set style fill solid 1.00 border 0;
set xtics rotate by -45;
set bars 0.5;
set style histogram errorbars gap 2 lw 1;
set output 'plot/error-rateWifi.png'; 
plot 'rs-errWifi.txt'  using 3:5:xtic(2) with histogram title 'NDNLP' fs pattern 3, 
      '' using 4:6:xtic(2) with histogram title 'NDN-NDP' fs pattern 2 ;"

EOM


# 'rs-err.txt'  using 3:4:xtic(2) with histogram title 'NDNLP' fs pattern 3, 
#      '' using 5:6:xtic(2) with histogram title 'NDN-NDP' fs pattern 2 ;"
