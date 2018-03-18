#!/bin/bash

#:%s/yakkety/artful/g
gnuplot -e <<EOM "
set terminal png enhanced font 'Times,16'; 
set key right ;
set ylabel '# of broadcast Interest';
set xlabel 'MTUs';
set yrange [1:];
set boxwidth 0.5;
set style fill solid 1.00 border 0;
set xtics rotate by -45;
set bars 0.5;
set style histogram errorbars gap 2 lw 1;
set output 'plot/interest-broadcast.png'; 
plot 'analyze-status.txt' using 2:4:xtic(1) with histogram title 'NDNLP' fs pattern 3 , 
     'analyze-status.txt' using 3:5:xtic(1) with histogram title 'NDN-NDP' fs pattern 2 ;"
EOM

gnuplot -e <<EOM "
set terminal png enhanced font 'Times,16'; 
set key right ;
set ylabel '# of broadcast Data';
set xlabel 'MTUs';
set yrange [1:];
set boxwidth 0.5;
set style fill solid 1.00 border 0;
set xtics rotate by -45;
set bars 0.5;
set style histogram errorbars gap 2 lw 1;
set output 'plot/data-broadcast.png'; 
plot 'analyze-statusd.txt' using 2:4:xtic(1) with histogram title 'NDNLP' fs pattern 3 , 
     'analyze-statusd.txt' using 3:5:xtic(1) with histogram title 'NDN-NDP' fs pattern 2 ;"
EOM

#Unsatisfied Interest 
gnuplot -e <<EOM "
set terminal png enhanced font 'Times,16'; 
set key right ;
set ylabel '# of Unsatisfied Interest';
set xlabel 'MTUs';
set yrange [0:600];
set boxwidth 0.5;
set style fill solid 1.00 border 0;
set xtics rotate by -45;
set bars 0.5;
set style histogram errorbars gap 2 lw 1;
set output 'plot/unsatisfied.png'; 
plot 'unsatisfied.txt'  using 2:4:xtic(1) with histogram title 'NDNLP' fs pattern 3, 
      'unsatisfied.txt' using 3:5:xtic(1) with histogram title 'NDN-NDP' fs pattern 2 ;"
EOM

gnuplot -e <<EOM "
set terminal png enhanced font 'Times,16'; 
set key right ;
set ylabel 'Delay (ms)';
set xlabel 'MTUs';
set yrange [0:];
set boxwidth 0.5;
set style fill solid 1.00 border 0;
set xtics rotate by -45;
set bars 0.5;
set style histogram errorbars gap 2 lw 1;
set output 'plot/delay.png'; 
plot 'delay.txt'  using 2:4:xtic(1) with histogram title 'NDNLP' fs pattern 3, 
      'delay.txt' using 3:5:xtic(1) with histogram title 'NDN-NDP' fs pattern 2 ;"
EOM


