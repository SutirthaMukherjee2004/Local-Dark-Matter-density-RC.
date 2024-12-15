set terminal postscript landscape enhanced color dashed defaultplex "Helvetica" 22
set encoding utf8 


set size ratio 0.75
set origin 0,0

set border 31 lt -1 lw 5


#set labels on the tic marks "%g"=1,"%.2f"=1.00,"%3.0e"=1e-01
set format x "% g"
set format y "% g"
set format x2 "% g"
set format y2 "% g"
set format z "% g"

set tics scale 2,1 font "Helvetica,30 "
#show tic marks inside
#set tics in
#set orgin of z axis 0.5 above xy plane 
set ticslevel 0.50

# sets major tic mark along x/y axis
set xtics
set ytics

# mx/ytics is the no of marks between adjacent marked points along axis
set mxtics 5.0
set mytics 2.0
set mx2tics 
set my2tics 
# <mirror> to put unlabelled tics on the oppsite axis

#set key noreverse nobox samplen 5 spacing 5 at 6.7,0.56 font "Helvetica,16 "

set style fill transparent solid 0.4 border
set style fill transparent pattern border


set xlabel " R [kpc]" font "Helvetica,30 "
set ylabel "v_c [km/sec]" font "Helvetica,30 "

##############################################################################################

set out 'Fig4b_vc_disk_collapsed_dgc_bw.eps'

set xra[0:25]  
set yra[0:500]

set key nobox top center spacing 2 samplen 8 at 6.5,475 font "Helvetica,30 "

plot './final_disk_8.3_244' u 1:2:3 with yerrorbars  pt 3 ps 2 lt 1 lw 4 lc rgb 'black' title '[8.3,244]',\
'./final_disk_8.5_220' u 1:2:3 with yerrorbars  pt 6 ps 2 lt 5 lw 4 lc rgb 'black' title '[8.5,220]',\
'./final_disk_8.0_200' u 1:2:3 with yerrorbars  pt 4 ps 2 lt 4 lw 4 lc rgb 'black' title '[8.0,200]'

################################################################################################
set out 'Fig4b_vc_disk_collapsed_dgc_clr.eps'

plot './final_disk_8.3_244' u 1:2:3 with yerrorbars  pt 3 ps 2 lt 1 lw 4 lc rgb 'red' title '[8.3,244]',\
'./final_disk_8.5_220' u 1:2:3 with yerrorbars  pt 6 ps 2 lt 5 lw 4 lc rgb 'blue' title '[8.5,220]',\
'./final_disk_8.0_200' u 1:2:3 with yerrorbars  pt 4 ps 2 lt 4 lw 4 lc rgb 'green' title '[8.0,200]'


#set out 'vc_log_disk_collapsed_dgc_bw.eps'
#set log x
#set xra[0.1:25]



