implicit real*8(a-h,o-z)

dimension r(5000),vc(5000),sigma(5000)

open(unit=2,file='vc_8.5_220_rash_BHB',status='unknown')
open(unit=3,file='vc_8.5_220_rash_KG',status='unknown')
open(unit=4,file='vc_8.5_220_rash_HS',status='unknown')

open(unit=13,file='final_vc_8.5_220_rash_5kpc',status='unknown')

pi=3.141592653589793d0


iBHB=16
iKG=28
iHS=9

do i=1,iBHB 
read(2,*)r(i),vc(i),sigma(i)
enddo


do i=1+iBHB,iKG+iBHB
read(3,*)r(i),vc(i),sigma(i)
enddo


do i=1+iKG+iBHB,iHS+iKG+iBHB
read(4,*)r(i),vc(i),sigma(i)
enddo

idatmax=iHS+iKG+iBHB
print*,r(1),r(iHS+iKG+iBHB),iHS+iKG+iBHB

call sort(idatmax,r,vc,sigma)  

gap=5.d0
do radius=25.0,190.0,gap

k=0
rad_mean=0.0
vc_mean=0.d0
errvc2=0.d0
deno=0.0

do j=1,idatmax
if (r(j).ge.radius.and.r(j).lt.radius+gap) then 
 k=k+1
 rad_mean=rad_mean+r(j)
 vc_mean=vc_mean+vc(j)/(sigma(j)*sigma(j))
 deno=deno+1.d0/(sigma(j)*sigma(j))
 errpd=1.0/dsqrt(deno)
! errvc2=errvc2+sigma(j)*sigma(j)




end if
end do ! j
print*,k,radius,radius+gap

rad_mean=rad_mean/k
vc_mean=vc_mean/deno
errvc=errpd



if(k.gt.0)write(13,*)rad_mean,vc_mean,errvc,k,radius,radius+gap

enddo ! radius


end


!************************************************************************************

	   SUBROUTINE sort(n,arr,arr2,arr3)  
	      implicit real*8(a-h,o-z)
              dimension arr(n),arr2(n),arr3(n)


              
	      do i=1,n-1
!	      if(arr(i).lt.1.d-2) cycle
	      do j=i+1,n
!	      if(arr(j).lt.1.d-2) cycle
	      a=arr(i)
	      b=arr(j)
	      c=arr2(i)
	      d=arr2(j)
	      e=arr3(i)
	      f=arr3(j)
	    

	 
	      if(arr(i).gt.arr(j)) then
	      arr(j)=a 
	      arr(i)=b
	      arr2(j)=c 
	      arr2(i)=d
	      arr3(j)=e
	      arr3(i)=f
	     

	      end if
	      end do
	      end do


return
end

	   





