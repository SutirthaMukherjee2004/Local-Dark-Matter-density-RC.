set terminal postscript landscape enhanced color dashed defaultplex "Helvetica" 22
set encoding utf8 



#set size ratio 1
set size 1.6,1.4
set origin -0.06,0

set border 31 lt -1 lw 8


#set labels on the tic marks "%g"=1,"%.2f"=1.00,"%3.0e"=1e-01
set format x "% g"
set format y "% g"
set format x2 "% g"
set format y2 "% g"
set format z "% g"

set tics scale 2,1 font "Helvetica,35 "
#show tic marks inside
#set tics in
#set orgin of z axis 0.5 above xy plane 
set ticslevel 0.50

# sets major tic mark along x/y axis
set xtics
set ytics

# mx/ytics is the no of marks between adjacent marked points along axis
set mxtics 5.0
set mytics 5.0
set mx2tics 
set my2tics 
# <mirror> to put unlabelled tics on the oppsite axis

#set key Middle noreverse nobox samplen 3 spacing 1.2 at 0.0,30.0 font "Helvetica,16 "

#set key nobox top center spacing 1 samplen 4.0 at 30,475 font "Helvetica,20 "

set key nobox spacing 5.8 samplen 4.0 at 24.9,475 font "Helvetica,23 "


set style fill transparent solid 0.1 border
set style fill transparent pattern border

set xlabel "R [kpc]" font "Helvetica,40 "
set ylabel offset -1.0,0.0
set ylabel "v_c [km/sec]" font "Helvetica,40 "

set xra [0:25]
set yra [0:500]
set label '[8.3,244]' at 0.5,450  font "Helvetica,45 "

###############################################################################################################
set out "Fig4a_vc_disk_8.3_244_individual_bw.eps"


plot '8.3_244_rmid_vcmean_errvc_W_HI' u 1:2:3 with yerrorbars lt 1 lw 4 ps 3 lc rgb "black" title 'HI-W76-B78',\
'8.3_244_rmid_vcmean_errvc_BG_CO' u 1:2:3 with yerrorbars lt 1 lw 4 ps 3 lc rgb "black"  title 'CO-B78',\
'8.3_244_rmid_vcmean_errvc_Clemens' u 1:2:3 with yerrorbars lt 1 lw 4 ps 3 lc rgb "black" title 'CO-C85',\
'8.3_244_rmid_vcmean_errvc_FB_HI' u 1:2:3 with yerrorbars lt 1 lw 4 ps 3 lc rgb "black" title 'HI-F89',\
'8.3_244_rmid_vcmean_errvc_FB_HII' u 1:2:3 with yerrorbars lt 1 lw 4 ps 3 lc rgb "black" title 'HII-F89',\
'8.3_244_rmid_vcmean_errvc_BB' u 1:2:3 with yerrorbars lt 1 lw 4 ps 3 lc rgb "black" title 'HII-RN-B93',\
'8.3_244_rmid_vcmean_errvc_Pont' u 1:2:3 with yerrorbars lt 1 lw 4 ps 3 lc rgb "black" title 'Cepheid-P94',\
'8.3_244_rmid_vcmean_errvc_maciel' u 1:2:3 with yerrorbars lt 1 lw 4 ps 3 lc rgb "black"  title 'PNe-M05-M84-D98',\
'8.3_244_rmid_vcmean_errvc_FM' u 1:2:3 with yerrorbars lt 1 lw 4 ps 3 lc rgb "black" title 'OSC-F08-D02',\
'8.3_244_rmid_vcmean_errvc_hou' u 1:2:3 with yerrorbars lt 1 lw 4 ps 3 lc rgb "black" title 'HII-H09',\
'8.3_244_rmid_vcmean_errvc_Urquhart_HII' u 1:2:3 with yerrorbars lt 1 lw 4 ps 3 lc rgb "black"  title 'HII-U11',\
'8.3_244_rmid_vcmean_errvc_demmers' u 1:2:3 with yerrorbars lt 1 lw 4 ps 3 lc rgb "black" title 'C stars-D07-B12'

###############################################################################################################
set out "Fig4a_vc_disk_8.3_244_individual_clr.eps"

plot '8.3_244_rmid_vcmean_errvc_W_HI' u 1:2:3 with yerrorbars lt 1 lw 4 ps 3 lc rgb "red" title 'HI-W76-B78',\
'8.3_244_rmid_vcmean_errvc_BG_CO' u 1:2:3 with yerrorbars lt 1 lw 4 ps 3 lc rgb "blue"  title 'CO-B78',\
'8.3_244_rmid_vcmean_errvc_Clemens' u 1:2:3 with yerrorbars lt 1 lw 4 ps 3 lc rgb "dark-green" title 'CO-C85',\
'8.3_244_rmid_vcmean_errvc_FB_HI' u 1:2:3 with yerrorbars lt 1 lw 4 ps 3 lc rgb "magenta" title 'HI-F89',\
'8.3_244_rmid_vcmean_errvc_FB_HII' u 1:2:3 with yerrorbars lt 1 lw 4 ps 3 lc rgb "dark-gray" title 'HII-F89',\
'8.3_244_rmid_vcmean_errvc_BB' u 1:2:3 with yerrorbars lt 1 lw 4 ps 3 lc rgb "orange" title 'HII-RN-B93',\
'8.3_244_rmid_vcmean_errvc_Pont' u 1:2:3 with yerrorbars lt 1 lw 4 ps 3 lc rgb "cyan" title 'Cepheid-P94',\
'8.3_244_rmid_vcmean_errvc_maciel' u 1:2:3 with yerrorbars lt 1 lw 4 ps 3 lc rgb "pink"  title 'PNe-M05-M84-D98',\
'8.3_244_rmid_vcmean_errvc_FM' u 1:2:3 with yerrorbars lt 1 lw 4 ps 3 lc rgb "khaki" title 'OSC-F08-D02',\
'8.3_244_rmid_vcmean_errvc_hou' u 1:2:3 with yerrorbars lt 1 lw 4 ps 3 lc rgb "purple" title 'HII-H09',\
'8.3_244_rmid_vcmean_errvc_Urquhart_HII' u 1:2:3 with yerrorbars lt 1 lw 4 ps 3 lc rgb "brown" title 'HII-U11',\
'8.3_244_rmid_vcmean_errvc_demmers' u 1:2:3 with yerrorbars lt 1 lw 4 ps 3 lc rgb "dark-blue" title 'C stars-D07-B12'











#pause -1


