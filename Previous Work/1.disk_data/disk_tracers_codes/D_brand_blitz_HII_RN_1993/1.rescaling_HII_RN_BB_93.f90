
implicit real*8(a-h,o-z)
dimension al(500),b(500),Rh(500),vh(5000)
dimension Rgsr(500),vlsr(500),vc(500),rx(500),ry(500),rz(500),vcbin(500)



open(unit=1,file='l_b_rh_erh_vh_evh_BB_1993',status='unknown')
open(unit=2,file='8.5_220_l_b_r_vc_x_y_z_BB',status='unknown')
open(unit=3,file='8.5_220_rmid_vcmean_errvc_BB',status='unknown')

pi=3.141592653589793d0

rsun=8.5d0
vsun=220.d0

!*****************6.4 km/sec addn chk&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

Upec=11.1d0 ! \pm 1.d0
Vpec=12.24  ! \pm 2.d0
Wpec=7.25   ! \pm 0.5d0
!*****************************************************

nd=0
ndtot=0
19 	read(1,*,iostat=ieof)x1,x2,x3,x4,x5,x6

	if(ieof.eq.0)then
ndtot=ndtot+1


xx=x3*dcos(x2*pi/180.0)*dsin(x1*pi/180.0)
yy=rsun-x3*dcos(x2*pi/180.0)*dcos(x1*pi/180.0)
zz=x3*dsin(x2*pi/180.0)
rreq=dsqrt(xx**2.d0+yy**2.d0)

if(((x1.ge.10.0.and.x1.le.170.0).or.(x1.ge.190.0.and.x1.le.350.0)).and.(dabs(zz).le.2.d0).and.(rreq.le.25.d0)) then
	nd=nd+1
	al(nd)=x1*pi/180.0
	b(nd)=x2*pi/180.0
        rh(nd)=x3
	vh(nd)=x5!+6.4d0
endif
	goto 19
	endif


ndmax=nd
print*,ndmax,ndtot
!191         206


do i=1,ndmax

rgcut=dsqrt(Rsun*Rsun+Rh(i)*Rh(i)*dcos(b(i))*dcos(b(i))-2.d0*Rsun*Rh(i)*dcos(b(i))*dcos(al(i)))

Rgsr(i)=rgcut
vlsr(i)=vh(i)+(Upec*dcos(b(i))*dcos(al(i))+Vpec*dcos(b(i))*dsin(al(i))+Wpec*dsin(b(i)))	

vc(i)=(rgsr(i)/Rsun)*(vlsr(i)/(dsin(al(i))*dcos(b(i)))+vsun)


rx(i)=rh(i)*dcos(b(i))*dsin(al(i))
ry(i)=rsun-rh(i)*dcos(b(i))*dcos(al(i))
rz(i)=rh(i)*dsin(b(i))

write(2,*)al(i)*180.0/pi,b(i)*180.0/pi,Rgsr(i),vc(i),rx(i),ry(i),rz(i)

enddo

call sort(ndmax,Rgsr,vc,rmax)


i=1
start=int(Rgsr(1))

200 vcmean=0.d0
rmean=0.d0
j=0

if(start.ge.0.d0) gap=0.25d0
if(start.ge.1.d0) gap=1.d0
if(start.ge.15.d0) gap=2.5d0
if(start.ge.17.5d0) gap=7.5d0


100 if((Rgsr(i).ge.start).and.(Rgsr(i).lt.start+gap)) then
vcmean=vc(i)+vcmean
rmean=Rgsr(i)+rmean
j=j+1
Vcbin(j)=vc(i)

i=i+1
goto 100
else
if(j.eq.0.or.j.eq.1) goto 400
sigma_dk=0
vcmean=vcmean/j
rmean=rmean/j
do k=1,j
sigma_dk=sigma_dk+(Vcbin(k)-vcmean)**2
end do
sigma_dk=dsqrt(sigma_dk/(j-1))

write(3,*)rmean,vcmean,sigma_dk,j,start+(gap/2.0),start,start+gap

400 if(start+gap.gt.rmax) goto 300
start=start+gap
goto 200
end if

300 end

!*********************************************************************


 SUBROUTINE sort(n,arr,arr2,rmax)  
	      implicit real*8(a-h,o-z)
              dimension arr(n),arr2(n)


              
	      do i=1,n-1
!	      if(arr(i).lt.1.d-2) cycle
	      do j=i+1,n
!	      if(arr(j).lt.1.d-2) cycle
	      a=arr(i)
	      b=arr(j)
	      c=arr2(i)
	      d=arr2(j)
	     
	 
	      if(arr(i).gt.arr(j)) then
	      arr(j)=a 
	      arr(i)=b
	      arr2(j)=c 
	      arr2(i)=d
	    
	      end if
	      end do
	      end do


               rmax=arr(n)

	      return
end





