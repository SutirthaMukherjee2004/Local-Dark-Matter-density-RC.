implicit real*8(a-h,o-z)

dimension r(5000),vc(5000),sigma(5000)

open(unit=11,file='8.3_244_rmid_vcmean_errvc',status='unknown')

open(unit=213,file='final_disk_8.3_244',status='unknown')

pi=3.141592653589793d0

!idatamax=101 for 8.0,200
idatamax=105  !for 8.5 and 8.3

do i=1,idatamax
read(11,*)r(i),vc(i),sigma(i)
enddo

print*,r(1),r(idatamax)

call sort(idatamax,r,vc,sigma)  



do nn=1,4

if (nn.eq.1)then
rmin=1.d-5
rmax=0.751d0
gap=0.25d0
elseif(nn.eq.2)then
rmin=1.0
rmax=14.d0
gap=1.d0
elseif(nn.eq.3)then
rmin=15.0
rmax=15.0d0
gap=2.5
elseif(nn.eq.4)then
rmin=17.5
rmax=17.5d0
gap=7.5d0
endif

if (nn.eq.1)then
rmin=1.d-5
rmax=0.751d0
gap=0.25d0
elseif(nn.eq.2)then
rmin=1.0
rmax=14.d0
gap=1.d0
elseif(nn.eq.3)then
rmin=15.0
rmax=15.0d0
gap=2.5
elseif(nn.eq.4)then
rmin=17.5
rmax=17.5d0
gap=7.5d0

endif






do radius=rmin,rmax,gap

k=0
rad_mean=0.0
vc_mean=0.d0
deno=0.0

do j=1,idatamax
if (r(j).ge.radius.and.r(j).lt.radius+gap) then 
 k=k+1
 rad_mean=rad_mean+r(j)
 vc_mean=vc_mean+vc(j)/(sigma(j)*sigma(j))
 deno=deno+1.d0/(sigma(j)*sigma(j))
! errvc2=errvc2+sigma(j)*sigma(j)
end if
end do ! j


errpd=1.0/dsqrt(deno)
rad_mean=rad_mean/k
vc_mean=vc_mean/deno
errvc=errpd


print*,k,radius,radius+gap,rad_mean,vc_mean
if(k.gt.0)write(213,*)rad_mean,vc_mean,errvc,k,radius,radius+gap

enddo ! radius
enddo ! nn binning loop

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

	   





