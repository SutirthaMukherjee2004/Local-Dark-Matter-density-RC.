implicit real*8(a-h,o-z)


parameter(imax=2145)
dimension Rdisk(10000),vdisk(10000),rnd(10000),vnd(10000),rnd_d_arr(10000),vnd_d_arr(10000)
dimension rr(10000),vv(10000),rbin(10000),vcbin(10000)

open(unit=1,file='disk_all_sorted_8.5_220_r_vc',status='unknown')


open(unit=13,file='final_disk_8.5_220',status='unknown')


pi=3.141592653589793d0


do i=1,imax
read(1,*)Rdisk(i),vdisk(i)
rr(i)=Rdisk(i)
vv(i)=vdisk(i)
enddo

!*************************************************

!################################### BINNING ##########################

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
rbin_mean=0.0
vcbin_mean=0.d0


do j=1,imax
if (rr(j).ge.radius.and.rr(j).lt.radius+gap) then 

 k=k+1
 rbin(k)=rr(j)
 rbin_mean=rbin_mean+rbin(k)
 vcbin(k)=vv(j)
 vcbin_mean=vcbin_mean+vcbin(k)
end if
end do

rbin_mean=rbin_mean/k
vcbin_mean=vcbin_mean/k

r_disp=0.0
vc_disp=0.0

do i=1,k
r_disp=r_disp+(rbin_mean-rbin(i))*(rbin_mean-rbin(i))
vc_disp=vc_disp+(vcbin_mean-vcbin(i))*(vcbin_mean-vcbin(i))
end do

r_disp=dsqrt(r_disp/(k-1))
vc_disp=dsqrt(vc_disp/(k-1))


!if(k .ge. 2)
write(13,*)rbin_mean,vcbin_mean,vc_disp,r_disp,radius,radius+gap,k

end do
enddo


end



	   





