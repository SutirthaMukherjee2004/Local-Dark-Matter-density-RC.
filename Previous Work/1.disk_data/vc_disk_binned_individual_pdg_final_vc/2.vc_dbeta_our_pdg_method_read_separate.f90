implicit real*8(a-h,o-z)

dimension r(5000),vc(5000),sigma(5000)

open(unit=11,file='8.0_200_rmid_vcmean_errvc_BB',status='unknown')
open(unit=12,file='8.0_200_rmid_vcmean_errvc_BG_CO',status='unknown')
open(unit=13,file='8.0_200_rmid_vcmean_errvc_Clemens',status='unknown')
open(unit=14,file='8.0_200_rmid_vcmean_errvc_demmers',status='unknown')
open(unit=15,file='8.0_200_rmid_vcmean_errvc_FB_HI',status='unknown')
open(unit=16,file='8.0_200_rmid_vcmean_errvc_FB_HII',status='unknown')
open(unit=17,file='8.0_200_rmid_vcmean_errvc_FM',status='unknown')
open(unit=18,file='8.0_200_rmid_vcmean_errvc_hou',status='unknown')
open(unit=19,file='8.0_200_rmid_vcmean_errvc_maciel',status='unknown')
open(unit=110,file='8.0_200_rmid_vcmean_errvc_Pont',status='unknown')
open(unit=111,file='8.0_200_rmid_vcmean_errvc_Urquhart_HII',status='unknown')
open(unit=112,file='8.0_200_rmid_vcmean_errvc_E_HI',status='unknown')


open(unit=213,file='final_vc_8.5_220_rash_5kpc',status='unknown')

pi=3.141592653589793d0

!8.0
i1=10
i2=7
i3=6
i4=8
i5=6
i6=10
i7=3
i8=13
i9=11
i10=9
i11=7
i12=11

!8.3
i1=10
i2=8
i3=7
i4=8
i5=7
i6=10
i7=3
i8=13
i9=10
i10=9
i11=8
i12=12

!8.5
i1=11
i2=8
i3=7
i4=8
i5=7
i6=11
i7=3
i8=12
i9=9
i10=9
i11=8
i12=12

do i=1,iBHB 
read(11,*)r(i),vc(i),sigma(i)
enddo


do i=1+iBHB,iKG+iBHB
read(12,*)r(i),vc(i),sigma(i)
enddo


do i=1+iKG+iBHB,iHS+iKG+iBHB
read(4,*)r(i),vc(i),sigma(i)
enddo

idatmax=iHS+iKG+iBHB
print*,r(1),r(iHS+iKG+iBHB),iHS+iKG+iBHB

call sort(idatmax,r,vc,sigma)  



do nn=1,4

if (nn.eq.1)then
rmin=1.d-5
rmax=0.75d0
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

	   





