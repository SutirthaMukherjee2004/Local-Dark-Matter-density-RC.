implicit real*8(a-h,o-z)
parameter(imax=2145) !2145

dimension Rold(3000),vold(3000),vcbin(3000),Rgsr(3000),vc(3000)

open(unit=1,file='disk_all_8.5_220',status='unknown')

open(unit=2,file='disk_all_sorted_8.5_220_r_vc',status='unknown')
!!191+279+143+61+150+89+49+299+254+105+317+209

pi=3.141592653589793d0


!*******************************************************************************
rsunold=8.5d0
vsunold=220.d0

!Rsunnew=8.d0
!Vsunnew=200.d0


Rsunnew=8.5d0
Vsunnew=220.d0

!Rsunnew=8.5d0
!Vsunnew=220.d0

!*******************************************************************************

do i=1,imax
read(1,*)x,x,Rold(i),vold(i),x,x,x
enddo

print*,Rold(imax),vold(imax)

!%%%%%%%%%%%%%%%%%%%  rescaling to DGC  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

do i=1,imax
	
Rgsr(i)=Rold(i)*Rsunnew/Rsunold
vc(i)=(Vold(i)*(Rsunold/Rold(i))-Vsunold+Vsunnew)*Rgsr(i)/Rsunnew

end do

!%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



call sort(imax,Rgsr,vc,rmax)

print*,rmax,'rmax'

do i=1,imax
write(2,*)Rgsr(i),vc(i)
enddo
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





