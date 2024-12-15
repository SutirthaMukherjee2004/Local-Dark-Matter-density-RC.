        implicit real*8(a-h,o-z)
        
        parameter(imax=317)
	dimension al(imax),b(imax),vtan(imax),dis1(imax),dis2(imax),dis3(imax),vc1(imax),vc2(imax),vc3(imax)
     	dimension vcbin1(imax),vcbin2(imax),vcbin3(imax)

	open(1,file='l_vtan_westerhout_1976_HI',status='unknown')

        open(unit=2,file='8.5_220_l_b_r_vc_x_y_z_W_HI',status='unknown')
        open(unit=3,file='8.0_200_l_b_r_vc_x_y_z_W_HI',status='unknown')
	open(unit=4,file='8.3_244_l_b_r_vc_x_y_z_W_HI',status='unknown')

        open(40,file='8.5_220_rmid_vcmean_errvc_W_HI',status='unknown')
        open(50,file='8.0_200_rmid_vcmean_errvc_W_HI',status='unknown')
        open(60,file='8.3_244_rmid_vcmean_errvc_W_HI',status='unknown')

!***********  Denhen & Binney **********
!Upec=10.0 ! \pm 1.d0
!Vpec=5.2  ! \pm 2.d0
!Wpec=7.2  ! \pm 0.5d0

Upec=11.1d0 ! \pm 1.d0
Vpec=12.24  ! \pm 2.d0
Wpec=7.25   ! \pm 0.5d0
!*****************************************************
!
	pi=3.141592653589793d0

	rsun1=8.5d0
	vsun1=220.d0

	rsun2=8.0d0
	vsun2=200.d0
	

	rsun3=8.3d0
	vsun3=244.d0

        do i=1,imax
        read(1,*)al(i),vtan(i)
        end do

       	do i=1,imax

	al(i)=al(i)*pi/180.d0
        b(i)=0.d0
 
	vtan(i)=vtan(i)+(Upec*dcos(b(i))*dcos(al(i))+Vpec*dcos(b(i))*dsin(al(i))+Wpec*dsin(b(i)))

	dis1(i)=dabs(rsun1*sin(al(i)))
	dis2(i)=dabs(rsun2*sin(al(i)))
	dis3(i)=dabs(rsun3*sin(al(i)))


	vc1(i)=dabs(vtan(i)+vsun1*sin(al(i)))
	vc2(i)=dabs(vtan(i)+vsun2*sin(al(i)))
	vc3(i)=dabs(vtan(i)+vsun3*sin(al(i)))




	r1=rsun1*sin(al(i))        
	r2=rsun2*sin(al(i))    
        r3=rsun3*sin(al(i))    


        write(2,*)al(i)*180.0/pi,0.d0,dis1(i),vc1(i),r1*cos(al(i)),r1*sin(al(i)),0.d0
	write(3,*)al(i)*180.0/pi,0.d0,dis2(i),vc2(i),r2*cos(al(i)),r2*sin(al(i)),0.d0
	write(4,*)al(i)*180.0/pi,0.d0,dis3(i),vc3(i),r3*cos(al(i)),r3*sin(al(i)),0.d0
	end do

 close(2)
 close(3)
 close(4)
!**************************** 1kpc binning 1 *******************

call sort(imax,dis1,vc1,rmax1)

print*,'set 1'
i=1
start=int(dis1(1))
gap=0.25d0


201 vcmean=0.d0
rmean=0.d0
j=0
   

if(start.ge.1.d0) gap=1.0d0

101 if((dis1(i).ge.start).and.(dis1(i).lt.start+gap)) then
vcmean=vc1(i)+vcmean
rmean=rmean+dis1(i)
j=j+1
Vcbin1(j)=vc1(i)

i=i+1
goto 101
else

if(j.eq.0.or.j.eq.1) goto 401
sigma_dk=0
vcmean=vcmean/j
rmean=rmean/j

do k=1,j
sigma_dk=sigma_dk+(Vcbin1(k)-vcmean)**2
end do
sigma_dk=dsqrt(sigma_dk/(j-1))

write(40,*)rmean,vcmean,sigma_dk,j,start+(gap/2.0),start,start+gap

401 if(start+gap.gt.rmax1) goto 302
start=start+gap
goto 201
end if




!**************************** 1kpc binning 2 *******************


302  close(40)
call sort(imax,dis2,vc2,rmax2)
print*,'set 2'
i=1
start=int(dis2(1))
gap=0.25d0

202 vcmean=0.d0
rmean=0.d0
j=0     
if(start.ge.1.d0) gap=1.0d0

102 if((dis2(i).ge.start).and.(dis2(i).lt.start+gap)) then
vcmean=vc2(i)+vcmean
rmean=rmean+dis2(i)
j=j+1
Vcbin2(j)=vc2(i)

i=i+1
goto 102
else
if(j.eq.0.or.j.eq.1) goto 402
sigma_dk=0
vcmean=vcmean/j
rmean=rmean/j
do k=1,j
sigma_dk=sigma_dk+(Vcbin2(k)-vcmean)**2
end do
sigma_dk=dsqrt(sigma_dk/(j-1))

write(50,*)rmean,vcmean,sigma_dk,j,start+(gap/2.0),start,start+gap

402 if(start+gap.gt.rmax2) goto 303
start=start+gap
goto 202
end if

!**************************** 1kpc binning 3 *******************


303  close(50)
call sort(imax,dis3,vc3,rmax3)
print*,'set 3'

i=1
start=int(dis3(1))
gap=0.25d0

203 vcmean=0.d0
rmean=0.d0
j=0       

if(start.ge.1.d0) gap=1.0d0

103 if((dis3(i).ge.start).and.(dis3(i).lt.start+gap)) then
vcmean=vc3(i)+vcmean
rmean=rmean+dis3(i)
j=j+1
Vcbin3(j)=vc3(i)

i=i+1
goto 103
else
if(j.eq.0.or.j.eq.1) goto 403
sigma_dk=0
vcmean=vcmean/j
rmean=rmean/j
do k=1,j
sigma_dk=sigma_dk+(Vcbin3(k)-vcmean)**2
end do
sigma_dk=dsqrt(sigma_dk/(j-1))

write(60,*)rmean,vcmean,sigma_dk,j,start+(gap/2.0),start,start+gap

403 if(start+gap.gt.rmax3) goto 1000
start=start+gap
goto 203
end if



1000  close(60)
end


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





