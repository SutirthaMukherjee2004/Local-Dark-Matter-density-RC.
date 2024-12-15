
implicit real*8(a-h,o-z)
dimension al(500),b(500),Rh(500),vh(5000)
dimension Rgsr(500),vlsr(500),vc(500),rx(500),ry(500),vcbin(500)


open(unit=1,file='circle_8.3',status='unknown')

rad =8.3d0
do x=-rad,rad,0.1
write(1,*)x,dsqrt(rad*rad-x*x)
!write(1,*)x,-dsqrt(rad*rad-x*x)
enddo
do x=rad,-rad,-0.1
!write(1,*)x,dsqrt(rad*rad-x*x)
write(1,*)x,-dsqrt(rad*rad-x*x)
enddo
write(1,*)-rad,0.0



end

