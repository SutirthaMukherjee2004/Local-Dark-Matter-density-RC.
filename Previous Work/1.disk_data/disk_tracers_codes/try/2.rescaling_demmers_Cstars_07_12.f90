
implicit real*8(a-h,o-z)
dimension al(500),b(500),Rh(500),vh(5000)
dimension Rgsr(500),vlsr(500),vc(500),rx(500),ry(500),rz(500),vcbin(500)



open(unit=1,file='l_b_rh_vh_demmers_2007_2012',status='unknown')
open(unit=2,file='8.3_244_l_b_r_vc_x_y_z_demmers',status='unknown')
open(unit=3,file='8.3_244_rmid_vcmean_errvc_demmers',status='unknown')

pi=3.141592653589793d0

rsun=8.3d0
vsun=244.d0


!***********  Denhen & Binney **********
!Upec=10.0 ! \pm 1.d0
!Vpec=5.2  ! \pm 2.d0
!Wpec=7.2  ! \pm 0.5d0

Upec=11.1d0 ! \pm 1.d0
Vpec=12.24  ! \pm 2.d0
Wpec=7.25   ! \pm 0.5d0
!*****************************************************
nd=0
ndtot=0
19 	read(1,*,iostat=ieof)x1,x2,x3,x4

	if(ieof.eq.0)then
ndtot=ndtot+1

xx=x3*dcos(x2)*dsin(x1)
yy=rsun-x3*dcos(x2)*dcos(x1)
zz=x3*dsin(x2)
rreq=dsqrt(xx**2.d0+yy**2.d0)

if((x1.gt. 54.0*pi/180.0 .and. x1.lt. 150.0*pi/180.0) .and. &
(dabs(x2).gt. 3.0*pi/180.0 .and.dabs(x2).lt. 9.0*pi/180.0).and.(dabs(zz).le.2.d0).and.(rreq.le.25.d0))then


	nd=nd+1
	al(nd)=x1
	b(nd)=x2
        rh(nd)=x3
	vh(nd)=x4
endif

	goto 19
	endif


ndmax=nd
print*,ndmax,ndtot
!61         111


do i=1,ndmax

Rgsr(i)=dsqrt(Rsun*Rsun+Rh(i)*Rh(i)*dcos(b(i))*dcos(b(i))-2.d0*Rsun*Rh(i)*dcos(b(i))*dcos(al(i)))


vlsr(i)=vh(i)+(Upec*dcos(b(i))*dcos(al(i))+Vpec*dcos(b(i))*dsin(al(i))+Wpec*dsin(b(i)))	

vc(i)=(rgsr(i)/Rsun)*(vlsr(i)/(dsin(al(i))*dcos(b(i)))+vsun)

rx(i)=rh(i)*dcos(b(i))*dsin(al(i))
ry(i)=rsun-rh(i)*dcos(b(i))*dcos(al(i))
rz(i)=rh(i)*dsin(b(i))

write(2,*)al(i)*180.0/pi,b(i)*180.0/pi,Rgsr(i),vc(i),rx(i),ry(i),rz(i)

enddo

call sort(ndmax,Rgsr,vc,rmax)
print*,Rgsr(1),Rgsr(ndmax)

i=1
start=int(Rgsr(1))
gap=1.d0

200 vcmean=0.d0
rmean=0.d0
j=0
if(start.ge.15.0d0) gap=3.d0
!if(start.ge.17.5d0) gap=7.5d0



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
write(*,*)rmean,vcmean,sigma_dk,j,start,start+gap

400 if(start+gap.gt.rmax) goto 300
start=start+gap
goto 200
end if


300 end



!*********************************************************************************


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





