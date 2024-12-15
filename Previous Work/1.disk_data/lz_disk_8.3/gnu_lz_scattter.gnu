set terminal postscript landscape enhanced color dashed defaultplex "Helvetica" 25
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
set mytics 5.0
set mx2tics 
set my2tics 
# <mirror> to put unlabelled tics on the oppsite axis

#set key Middle noreverse nobox samplen 3 spacing 1.2 at 



set style fill transparent solid 0.4 border
set style fill transparent pattern border



set xlabel "l [degree]" font "Helvetica,30 "
set ylabel "z [kpc]" font "Helvetica,30 "

set xra[0.0:360] 
set yra[-2.0:2.0]

set size square
# done with GC at (0,0)..and sun along +ve y axis (0,8.5)..and after cuts
set key nobox top center samplen 2 at 210.0,1.5 font "Helvetica,33 "


#**********************************************************************
set out "Fig3_1.Westerhout_HI_lz.eps"

plot './8.3_244_l_b_r_vc_x_y_z_W_HI' u 1:7 w p ps 1.2 pt 2 lw 3 lc rgb "black" title 'HI-W76-B78'


#**********************************************************************
set out "Fig3_2.BG_CO_lz.eps"

plot './8.3_244_l_b_r_vc_x_y_z_BG_CO' u 1:7 w p ps 1.2 pt 2 lw 3 lc rgb "black" title 'CO-B78'

#**********************************************************************
set out "Fig3_3.Clemens_lz.eps"

plot './8.3_244_l_b_r_vc_x_y_z_Clemens_CO' u 1:7 w p ps 1.2 pt 2 lw 3 lc rgb "black" title 'CO-C85'

#**********************************************************************
set out "Fig3_4.FB_HI_lz.eps"

plot './8.3_244_l_b_r_vc_x_y_z_FB_HI' u 1:7 w p ps 1.2 pt 2 lw 3 lc rgb "black" title 'HI-F89'

#**********************************************************************
set out "Fig3_5.FB_HII_lz.eps"
plot './8.3_244_l_b_r_vc_x_y_z_FB_HII' u 1:7 w p ps 1.2 pt 2 lw 3 lc rgb "black" title 'HII-F89'

#**********************************************************************

set out "Fig3_6.BB_lz.eps"
plot './8.3_244_l_b_r_vc_x_y_z_BB' u 1:7 w p ps 1.2 pt 2 lw 3 lc rgb "black" title 'HII-RN-B93'


#**********************************************************************
set out "Fig3_7.Pont_lz.eps"

plot './8.3_244_l_b_r_vc_x_y_z_Pont' u 1:7 w p ps 1.2 pt 2 lw 3 lc rgb "black" title 'Cepheid-P94'

#**********************************************************************


set out "Fig3_8.Maciel_lz.eps"
plot './8.3_244_l_b_r_vc_x_y_z_maciel' u 1:7 w p ps 1.2 pt 2 lw 3 lc rgb "black" title 'PNe-M05-M84-D98'

#**********************************************************************
set out "Fig3_9.FM_lz.eps"

plot './8.3_244_l_b_r_vc_x_y_z_FM' u 1:7 w p ps 1.2 pt 2 lw 3 lc rgb "black" title 'OSC-F08-D02'


#**********************************************************************

set out "Fig3_10.Hou_lz.eps"
plot './8.3_244_l_b_r_vc_x_y_z_hou' u 1:7 w p ps 1.2 pt 2 lw 3 lc rgb "black" title 'HII-H09'


#**********************************************************************
set out "Fig3_11.Urquhart_HII_lz.eps"

plot './8.3_244_l_b_r_vc_x_y_z_Urquhart_HII' u 1:7 w p ps 1.2 pt 2 lw 3 lc rgb "black" title 'HII-U11'

#**********************************************************************
set out "Fig3_12.Demmers_lz.eps"

plot './8.3_244_l_b_r_vc_x_y_z_demmers' u 1:7 w p ps 1.2 pt 2 lw 3 lc rgb "black" title 'C stars-D07-B12'


################################################################################
#*******************************************************************************


set out "Fig3_1.Westerhout_HI_lz_clr.eps"

plot './8.3_244_l_b_r_vc_x_y_z_W_HI' u 1:7 w p ps 1.2 pt 2 lw 3 lc rgb "red" title 'HI-W76-B78'


#**********************************************************************
set out "Fig3_2.BG_CO_lz_clr.eps"

plot './8.3_244_l_b_r_vc_x_y_z_BG_CO' u 1:7 w p ps 1.2 pt 2 lw 3 lc rgb "blue" title 'CO-B78'

#**********************************************************************
set out "Fig3_3.Clemens_lz_clr.eps"

plot './8.3_244_l_b_r_vc_x_y_z_Clemens_CO' u 1:7 w p ps 1.2 pt 2 lw 3 lc rgb "forest-green" title 'CO-C85'

#**********************************************************************
set out "Fig3_4.FB_HI_lz_clr.eps"

plot './8.3_244_l_b_r_vc_x_y_z_FB_HI' u 1:7 w p ps 1.2 pt 2 lw 3 lc rgb "red" title 'HI-F89'

#**********************************************************************
set out "Fig3_5.FB_HII_lz_clr.eps"
plot './8.3_244_l_b_r_vc_x_y_z_FB_HII' u 1:7 w p ps 1.2 pt 2 lw 3 lc rgb "blue" title 'HII-F89'

#**********************************************************************

set out "Fig3_6.BB_lz_clr.eps"
plot './8.3_244_l_b_r_vc_x_y_z_BB' u 1:7 w p ps 1.2 pt 2 lw 3 lc rgb "forest-green" title 'HII-RN-B93'


#**********************************************************************
set out "Fig3_7.Pont_lz_clr.eps"

plot './8.3_244_l_b_r_vc_x_y_z_Pont' u 1:7 w p ps 1.2 pt 2 lw 3 lc rgb "red" title 'Cepheid-P94'

#**********************************************************************


set out "Fig3_8.Maciel_lz_clr.eps"
plot './8.3_244_l_b_r_vc_x_y_z_maciel' u 1:7 w p ps 1.2 pt 2 lw 3 lc rgb "blue" title 'PNe-M05-M84-D98'

#**********************************************************************
set out "Fig3_9.FM_lz_clr.eps"

plot './8.3_244_l_b_r_vc_x_y_z_FM' u 1:7 w p ps 1.2 pt 2 lw 3 lc rgb "forest-green" title 'OSC-F08-D02'


#**********************************************************************

set out "Fig3_10.Hou_lz_clr.eps"
plot './8.3_244_l_b_r_vc_x_y_z_hou' u 1:7 w p ps 1.2 pt 2 lw 3 lc rgb "red" title 'HII-H09'


#**********************************************************************
set out "Fig3_11.Urquhart_HII_lz_clr.eps"

plot './8.3_244_l_b_r_vc_x_y_z_Urquhart_HII' u 1:7 w p ps 1.2 pt 2 lw 3 lc rgb "blue" title 'HII-U11'

#**********************************************************************
set out "Fig3_12.Demmers_lz_clr.eps"

plot './8.3_244_l_b_r_vc_x_y_z_demmers' u 1:7 w p ps 1.2 pt 2 lw 3 lc rgb "forest-green" title 'C stars-D07-B12'


#**********************************************************************












