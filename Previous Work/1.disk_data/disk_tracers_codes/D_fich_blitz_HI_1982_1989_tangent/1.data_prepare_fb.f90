
implicit real*8(a-i,o-z)


open(unit=1,file='FB_1989_HI.txt',status='unknown')
open(unit=2,file='FB_1989_HI_271.txt',status='unknown')
open(unit=3,file='l_vtan_FB_1989_HI.txt',status='unknown')


do i=15,89
read(1,*)x
write(3,*)i,x
enddo

do i=271,345
read(2,*)x
write(3,*)i,-x
enddo


end

