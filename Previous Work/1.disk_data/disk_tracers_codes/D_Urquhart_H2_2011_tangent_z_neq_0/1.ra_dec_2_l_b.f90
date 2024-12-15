!see values quoted here : http://cxc.harvard.edu/ciao/ahelp/prop-coords.html
!# #######################################################################
!# Convert Equatorial coordinates to Galactic coordinates in the epoch J2000
!# #########################################################################
!def eq2gal(ra,dec):
!    Convert Equatorial coordinates to Galactic Coordinates in the epch J2000.
    
!    ra  -- Right Ascension (in radians)
!    dec -- Declination (in radians)

!    l -- Galactic longitude (in radians)
!    b -- Galactic latitude (in radians)



!# RA(radians),Dec(radians),distance(kpc) of Galactic center in J2000
!Galactic_Center_Equatorial=(math.radians(266.40510), math.radians(-28.936175), 8.33)

!# RA(radians),Dec(radians) of Galactic Northpole in J2000
!Galactic_Northpole_Equatorial=(math.radians(192.859508), math.radians(27.128336))

implicit real*8(a-h,o-z)
dimension ra(5000),dec(5000),vh(5000),evh(5000),rh(5000),erh(5000),rgc(5000),ergc(5000)
dimension al(5000),b(5000),alcal1(5000),alcal2(5000),alcal3(5000),bcal(5000)

open(unit=1,file='ra3_dec3_vt_urquhart11_HII',status='unknown')
! ihn Urquhart data input : RA in h:m:s and dec in d:m:s
open(unit=2,file='l_b_vt_Urquhart_2011_HII',status='unknown')

pi=3.141592653589793d0
nd=0


 19	read(1,*,iostat=ieof1)x1,x2,x3,x4,x5,x6,x7
       	!print*,x1,x2,x3,x4,x5,x6,x7,nd
	if(ieof1.eq.0)then
	nd=nd+1
	ra(nd)=((x1*60.0+x2+x3/60.0)/4.0)*pi/180.0
	dec(nd)=(x4+x5/60.0+x6/3600.0)*pi/180.0
	vh(nd)=x7

	goto 19
	endif

ndmax=nd
print*,ndmax!,sin(45.0),sin(45.0*pi/180.0),mod(5.0,2.0)




alpha = 192.859508*pi/180.0  !Galactic_Northpole_Equatorial[0]: RA of GNP
delta = 27.128336*pi/180.0   !Galactic_Northpole_Equatorial[1]: decli of GNP
ala = 33.0*pi/180.0          !math.radians(33.0): 

do j=1,ndmax
   
bcal(j) = asin(sin(dec(j))*sin(delta)+cos(dec(j))*cos(delta)*cos(ra(j)-alpha))

alcal1(j) = ((cos(dec(j))*sin(ra(j)-alpha))/cos(bcal(j)))! cos(l-l0)
alcal2(j)=(sin(dec(j))*cos(delta)-cos(dec(j))*sin(delta)*cos(ra(j)-alpha))/cos(bcal(j))! sin(l-l0)
alcal3(j) = (sin(dec(j))*cos(delta)-cos(dec(j))*sin(delta)*cos(ra(j)-alpha)) &
 /(cos(dec(j))*sin(ra(j)-alpha))!tan(l-l0)

! the acos fn can give two diff results for angle (ie. l) depending on it's value..can give q:1/4 value if >0 or q:2/3 value if <0
! angcos 1 and 2 calculates the two possibilities.

angcos1=acos(alcal1(j))
angcos2=2.0*pi-angcos1 

! comparing the corresponding sin values to pick the right angcos 1 or 2.

if(dabs(sin(angcos1)-alcal2(j)).le.0.0001d0)then
angle=angcos1+ala
else
angle=angcos2+ala
endif

if(angle.ge.2.0*pi)angle=angle-2.d0*pi 

al(j)=angle
write(2,*)al(j)*180.0/pi,bcal(j)*180.0/pi,vh(j)
enddo

stop 
end




!formula in ref : 
!b = asin(sin(dec)*cos(i_g) - cos(dec)*sin(i_g)*sin(ra-alpha))
!l = atan((sin(dec)*sin(i_g) + cos(dec)*cos(i_g)*sin(ra-alpha))/(cos(dec)*cos(ra-alpha)))+la

!i_g=90-delta and alpha_N=alpha+90 
!so in paper: ra-alpha_N=ra-alpha-90 

!>> cos(ra-alpha_N)=cos(ra-alpha-90)=cos(90-ra+alpha)=sin(ra-alpha)
!>> sin(ra-alpha_N)=sin(ra-alpha-90)=-sin(90-ra+alpha)=-cos(ra-alpha)


















!# ########################################################################
!# Convert Galactic coordinates to Equatorial coordinates in the epoch J2000
!# ########################################################################
!    Convert Galatic coordinates to Equatorial Coordinates in the epch J2000.
    
!    l -- Galactic longitude (in radians)
!    b -- Galactic latitude (in radians)

 !   ra  -- Right Ascension (in radians)
 !   dec -- Declination (in radians)
 
 !   alpha = Galactic_Northpole_Equatorial[0]
 !   delta = Galactic_Northpole_Equatorial[1]
 !   la = math.radians(33.0)

 !   dec = math.asin(math.sin(b) * math.sin(delta) +
 !                   math.cos(b) * math.cos(delta) * math.sin(l - la))

 !   ra = math.atan2(math.cos(b) * math.cos(l - la), 
 !                   math.sin(b) * math.cos(delta) - 
 !                   math.cos(b) * math.sin(delta) * math.sin(l - la) 
 !                   ) + alpha

!    ra = ra if ra>=0 else (ra + math.pi * 2.0)

!    ra = ra % (2.0 * math.pi)
    
!# #The end of gal2eq ####################################################


