reset
set term png enhanced lw 2 font "Times,18"
set output "implicit.png"
set noborder
set size square
set contour
set cntrparam levels discrete 0
set view map
unset surface
set nokey
set isosamples 1000,1000
set xrange [-1:1]
set yrange [-1:2]
#set xlabel "x"
#set ylabel "y"
#set title "Implicit plot of sin(x^2+y^2)=exp(-xy)"
set notics
#set style line 

splot x**2.0+(y-(x**2.0)**(1.0/3.0))**2.0-1.0 lw 4,x**2.0+(y-(x**2.0)**(1.0/3.0))**2.0-1.0 lw 4
#with filledcurves
#w l lw 4 lc rgb "green" 

