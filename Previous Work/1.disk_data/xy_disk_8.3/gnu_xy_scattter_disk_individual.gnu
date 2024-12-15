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
set mytics 5.0
set mx2tics 
set my2tics 
# <mirror> to put unlabelled tics on the oppsite axis

#set key Middle noreverse nobox samplen 3 spacing 1.2 at 0.0,30.0 font "Helvetica,25 "
set key nobox top center samplen 3 at 10.0,27.0 font "Helvetica,33 "

set style fill transparent solid 0.4 border
set style fill transparent pattern border



set xlabel "x [kpc]" font "Helvetica,30 "
set ylabel "y [kpc]" font "Helvetica,30 "

set xra[-30:30]  
set yra[-30:30]

set size square

#set arrow from 20,-22 to 0,8.3 lw 2 
#set label 'sun' at 19,-24 font "Helvetica,35"

# done with GC at (0,0)..and sun along +ve y axis (0,8.5)..and after cuts


#'./circle_25' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle
#**********************************************************************
set out "Fig2_1.Westerhout_HI_xy.eps"

plot './8.3_244_l_b_r_vc_x_y_z_W_HI' u 5:6 w p ps 1.2 pt 2 lw 3 lc rgb "black" title 'HI-W76-B78',\
'./sun_8.3' u 1:2 w p ps 2 pt 6 lw 7 lc rgb "black" notitle,\
'./circle_2'  u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_5' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_8.3' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_15' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_20' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle

#**********************************************************************

set out "Fig2_2.BG_CO_xy.eps"

plot './8.3_244_l_b_r_vc_x_y_z_BG_CO' u 5:6 w p ps 1.2 pt 2 lw 3 lc rgb "black" title 'CO-B78',\
'./sun_8.3' u 1:2 w p ps 2 pt 6 lw 7 lc rgb "black" notitle,\
'./circle_2'  u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_5' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_8.3' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_15' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_20' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle


#**********************************************************************
set out "Fig2_3.Clemens_xy.eps"

plot './8.3_244_l_b_r_vc_x_y_z_Clemens_CO' u 5:6 w p ps 1.2 pt 2 lw 3 lc rgb "black" title 'CO-C85',\
'./sun_8.3' u 1:2 w p ps 2 pt 6 lw 7 lc rgb "black" notitle,\
'./circle_2'  u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_5' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_8.3' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_15' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_20' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle


#**********************************************************************
set out "Fig2_4.FB_HI_xy.eps"

plot './8.3_244_l_b_r_vc_x_y_z_FB_HI' u 5:6 w p ps 1.2 pt 2 lw 3 lc rgb "black" title 'HI-F89',\
'./sun_8.3' u 1:2 w p ps 2 pt 6 lw 7 lc rgb "black" notitle,\
'./circle_2'  u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_5' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_8.3' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_15' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_20' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle

#**********************************************************************
set out "Fig2_5.FB_HII_xy.eps"
plot './8.3_244_l_b_r_vc_x_y_z_FB_HII' u 5:6 w p ps 1.2 pt 2 lw 3 lc rgb "black" title 'HII-F89',\
'./sun_8.3' u 1:2 w p ps 2 pt 6 lw 7 lc rgb "black" notitle,\
'./circle_2'  u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_5' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_8.3' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_15' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_20' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle

#**********************************************************************


set out "Fig2_6.BB_xy.eps"
plot './8.3_244_l_b_r_vc_x_y_z_BB' u 5:6 w p ps 1.2 pt 2 lw 3 lc rgb "black" title 'HII-RN-B93',\
'./sun_8.3' u 1:2 w p ps 2 pt 6 lw 7 lc rgb "black" notitle,\
'./circle_2'  u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_5' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_8.3' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_15' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_20' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle

#**********************************************************************
set out "Fig2_7.Pont_xy.eps"

plot './8.3_244_l_b_r_vc_x_y_z_Pont' u 5:6 w p ps 1.2 pt 2 lw 3 lc rgb "black" title 'Cepheid-P94',\
'./sun_8.3' u 1:2 w p ps 2 pt 6 lw 7 lc rgb "black" notitle,\
'./circle_2'  u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_5' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_8.3' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_15' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_20' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle


#**********************************************************************

set out "Fig2_8.Maciel_xy.eps"
plot './8.3_244_l_b_r_vc_x_y_z_maciel' u 5:6 w p ps 1.2 pt 2 lw 3 lc rgb "black" title 'PNe-M05-M84-D98',\
'./sun_8.3' u 1:2 w p ps 2 pt 6 lw 7 lc rgb "black" notitle,\
'./circle_2'  u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_5' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_8.3' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_15' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_20' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle

#**********************************************************************
set out "Fig2_9.FM_xy.eps"

plot './8.3_244_l_b_r_vc_x_y_z_FM' u 5:6 w p ps 1.2 pt 2 lw 3 lc rgb "black" title 'OSC-F08-D02',\
'./sun_8.3' u 1:2 w p ps 2 pt 6 lw 7 lc rgb "black" notitle,\
'./circle_2'  u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_5' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_8.3' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_15' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_20' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle



#**********************************************************************
set out "Fig2_10.Hou_xy.eps"
plot './8.3_244_l_b_r_vc_x_y_z_hou' u 5:6 w p ps 1.2 pt 2 lw 3 lc rgb "black"title 'HII-H09',\
'./sun_8.3' u 1:2 w p ps 2 pt 6 lw 7 lc rgb "black" notitle,\
'./circle_2'  u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_5' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_8.3' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_15' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_20' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle



#**********************************************************************
set out "Fig2_11.Urquhart_HII_xy.eps"

plot './8.3_244_l_b_r_vc_x_y_z_Urquhart_HII' u 5:6 w p ps 1.2 pt 2 lw 3 lc rgb "black" title 'HII-U11',\
'./sun_8.3' u 1:2 w p ps 2 pt 6 lw 7 lc rgb "black" notitle,\
'./circle_2'  u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_5' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_8.3' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_15' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_20' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle

#**********************************************************************
set out "Fig2_12.Demmers_xy.eps"
plot './8.3_244_l_b_r_vc_x_y_z_demmers' u 5:6 w p ps 1.2 pt 2 lw 3 lc rgb "black" title 'C stars-D07-B12',\
'./sun_8.3' u 1:2 w p ps 2 pt 6 lw 7 lc rgb "black" notitle,\
'./circle_2'  u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_5' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_8.3' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_15' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_20' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle

################################################################################
set out "Fig2_1.Westerhout_HI_xy_clr.eps"

plot './8.3_244_l_b_r_vc_x_y_z_W_HI' u 5:6 w p ps 1.2 pt 2 lw 3 lc rgb "red" title 'HI-W76-B78',\
'./sun_8.3' u 1:2 w p ps 2 pt 6 lw 7 lc rgb "black" notitle,\
'./circle_2'  u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_5' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_8.3' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_15' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_20' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle

#**********************************************************************

set out "Fig2_2.BG_CO_xy_clr.eps"

plot './8.3_244_l_b_r_vc_x_y_z_BG_CO' u 5:6 w p ps 1.2 pt 2 lw 3 lc rgb "blue" title 'CO-B78',\
'./sun_8.3' u 1:2 w p ps 2 pt 6 lw 7 lc rgb "black" notitle,\
'./circle_2'  u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_5' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_8.3' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_15' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_20' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle


#**********************************************************************
set out "Fig2_3.Clemens_xy_clr.eps"

plot './8.3_244_l_b_r_vc_x_y_z_Clemens_CO' u 5:6 w p ps 1.2 pt 2 lw 3 lc rgb "forest-green" title 'CO-C85',\
'./sun_8.3' u 1:2 w p ps 2 pt 6 lw 7 lc rgb "black" notitle,\
'./circle_2'  u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_5' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_8.3' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_15' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_20' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle


#**********************************************************************
set out "Fig2_4.FB_HI_xy_clr.eps"

plot './8.3_244_l_b_r_vc_x_y_z_FB_HI' u 5:6 w p ps 1.2 pt 2 lw 3 lc rgb "red" title 'HI-F89',\
'./sun_8.3' u 1:2 w p ps 2 pt 6 lw 7 lc rgb "black" notitle,\
'./circle_2'  u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_5' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_8.3' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_15' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_20' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle

#**********************************************************************
set out "Fig2_5.FB_HII_xy_clr.eps"
plot './8.3_244_l_b_r_vc_x_y_z_FB_HII' u 5:6 w p ps 1.2 pt 2 lw 3 lc rgb "blue" title 'HII-F89',\
'./sun_8.3' u 1:2 w p ps 2 pt 6 lw 7 lc rgb "black" notitle,\
'./circle_2'  u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_5' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_8.3' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_15' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_20' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle

#**********************************************************************


set out "Fig2_6.BB_xy_clr.eps"
plot './8.3_244_l_b_r_vc_x_y_z_BB' u 5:6 w p ps 1.2 pt 2 lw 3 lc rgb "forest-green" title 'HII-RN-B93',\
'./sun_8.3' u 1:2 w p ps 2 pt 6 lw 7 lc rgb "black" notitle,\
'./circle_2'  u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_5' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_8.3' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_15' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_20' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle

#**********************************************************************
set out "Fig2_7.Pont_xy_clr.eps"

plot './8.3_244_l_b_r_vc_x_y_z_Pont' u 5:6 w p ps 1.2 pt 2 lw 3 lc rgb "red" title 'Cepheid-P94',\
'./sun_8.3' u 1:2 w p ps 2 pt 6 lw 7 lc rgb "black" notitle,\
'./circle_2'  u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_5' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_8.3' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_15' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_20' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle


#**********************************************************************

set out "Fig2_8.Maciel_xy_clr.eps"
plot './8.3_244_l_b_r_vc_x_y_z_maciel' u 5:6 w p ps 1.2 pt 2 lw 3 lc rgb "blue" title 'PNe-M05-M84-D98',\
'./sun_8.3' u 1:2 w p ps 2 pt 6 lw 7 lc rgb "black" notitle,\
'./circle_2'  u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_5' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_8.3' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_15' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_20' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle

#**********************************************************************
set out "Fig2_9.FM_xy_clr.eps"

plot './8.3_244_l_b_r_vc_x_y_z_FM' u 5:6 w p ps 1.2 pt 2 lw 3 lc rgb "forest-green" title 'OSC-F08-D02',\
'./sun_8.3' u 1:2 w p ps 2 pt 6 lw 7 lc rgb "black" notitle,\
'./circle_2'  u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_5' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_8.3' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_15' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_20' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle



#**********************************************************************
set out "Fig2_10.Hou_xy_clr.eps"
plot './8.3_244_l_b_r_vc_x_y_z_hou' u 5:6 w p ps 1.2 pt 2 lw 3 lc rgb "red" title 'HII-H09',\
'./sun_8.3' u 1:2 w p ps 2 pt 6 lw 7 lc rgb "black" notitle,\
'./circle_2'  u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_5' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_8.3' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_15' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_20' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle



#**********************************************************************
set out "Fig2_11.Urquhart_HII_xy_clr.eps"

plot './8.3_244_l_b_r_vc_x_y_z_Urquhart_HII' u 5:6 w p ps 1.2 pt 2 lw 3 lc rgb "blue" title 'HII-U11',\
'./sun_8.3' u 1:2 w p ps 2 pt 6 lw 7 lc rgb "black" notitle,\
'./circle_2'  u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_5' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_8.3' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_15' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_20' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle

#**********************************************************************
set out "Fig2_12.Demmers_xy_clr.eps"
plot './8.3_244_l_b_r_vc_x_y_z_demmers' u 5:6 w p ps 1.2 pt 2 lw 3 lc rgb "forest-green" title 'C stars-D07-B12',\
'./sun_8.3' u 1:2 w p ps 2 pt 6 lw 7 lc rgb "black" notitle,\
'./circle_2'  u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_5' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_8.3' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_15' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle,\
'./circle_20' u 1:2 w l lt 2 lw 2 lc rgb "black" notitle

