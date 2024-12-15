
implicit real*8(a-h,o-z)
dimension ra(500),dec(500),al(500),b(500),Rh(500),erh(500),Rgsr(500),vh(5000),evh(5000)
dimension R(500),vgsr(500),vlsrd(500),vlsr(500)



open(unit=1,file='id_l_b_vh_evh_vlsr_demmers2007',status='unknown')
open(unit=2,file='id_ra3_dec3_rh_rg_z_hv_evh_vlsr_demmers2007',status='unknown')
open(unit=3,file='id_ra3_dec3_l_b_rg_vh_evh_demmers2012',status='unknown')

open(unit=4,file='l_b_rh_vh_demmers_2007_2012',status='unknown')

pi=3.141592653589793d0
rsun=7.62d0 ! the value they took
vsun=220.d0
nd1=0
nd2=0


19 	read(1,*,iostat=ieof1)x1,x2,x3,x4,x5,x6


	if(ieof1.eq.0)then
	nd1=nd1+1

	al(nd1)=x2*pi/180.0
	b(nd1)=x3*pi/180.0
        vh(nd1)=x4
	evh(nd1)=x5
	vlsrd(nd1)=x6


	goto 19
	endif


nd1m=nd1
print*,nd1m

20 	read(2,*,iostat=ieof2)xx1,xx2,xx3,xx4,xx5,xx6,xx7,xx8,xx9,xx10,xx11,xx12,xx13


	if(ieof2.eq.0)then
	nd2=nd2+1

   	Rh(nd2)=xx8
	Rgsr(nd2)=xx9
!	xrh=(Rsun*dcos(al(nd2)) + dsqrt(Rgsr(nd2)*Rgsr(nd2)-Rsun*Rsun*dsin(al(nd2))*dsin(al(nd2))))/dcos(b(nd2))
!	xrgsr=dsqrt(Rsun*Rsun+xrh*xrh*dcos(b(nd2))*dcos(b(nd2))-2.d0*Rsun*xrh*dcos(b(nd2))*dcos(al(nd2)))
!	xrgsr=dsqrt(Rsun*Rsun+Rh(nd2)*Rh(nd2)*dcos(b(nd2))*dcos(b(nd2))-2.d0*Rsun*Rh(nd2)*dcos(b(nd2))*dcos(al(nd2)))
!       write(4,*)Rh(nd2),xrh,Rgsr(nd2),xrgsr

	goto 20
	endif


nd2m=nd2

print*,nd2m

nd12m=nd1m+nd2m
!***********  Denhen & Binney **********
!Upec=10.0 ! \pm 1.d0
!Vpec=5.2  ! \pm 2.d0
!Wpec=7.2  ! \pm 0.5d0

Upec=11.1d0 ! \pm 1.d0
Vpec=12.24  ! \pm 2.d0
Wpec=7.25   ! \pm 0.5d0


nd3=nd1m

21	read(3,*,iostat=ieof3)x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12


	if(ieof3.eq.0)then
	nd3=nd3+1
	al(nd3)=x8*pi/180.0
	b(nd3)=x9*pi/180.0

	Rgsr(nd3)=x10
	Rh(nd3)=(Rsun*dcos(al(nd3)) + dsqrt(Rgsr(nd3)*Rgsr(nd3)-Rsun*Rsun*dsin(al(nd3))*dsin(al(nd3))))/dcos(b(nd3))
        vh(nd3)=x11


	goto 21
	endif
ndmax=nd3

print*,ndmax!,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12

do i=1,ndmax

write(4,*)al(i),b(i),Rh(i),vh(i)

!R(i)=dsqrt(Rsun*Rsun+Rh(i)*Rh(i)*dcos(b(i))*dcos(b(i))-2.d0*Rsun*Rh(i)*dcos(b(i))*dcos(al(i)))
!vlsr(i)=vh(i)+(Upec*dcos(b(i))*dcos(al(i))+Vpec*dcos(b(i))*dsin(al(i))+Wpec*dsin(b(i)))

enddo

stop 
end



