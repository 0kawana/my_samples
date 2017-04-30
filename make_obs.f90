! gfortran -c mt_64.f95
! gfortran make_obs.f90 mt_64.o
! ./a.out
program make_obs
use, intrinsic :: iso_fortran_env
use mt19937_64
implicit none

integer,parameter:: NN = 1460
integer, parameter :: i8 = int64
real, dimension(1:40,1:NN):: x
real, dimension(1:NN) :: dxbar,hx
real PI
integer i, n
character(len=80) filename

PI = 3.14159265359

!set initial value
open (17, file='sec/lorenz96_rk4_nature.txt', status='old')
do n = 1,NN
    read (17, *) x(:,n)
end do
close (17)

call init_genrand64(1_i8)

do n = 1,NN
	do i = 1,40
		x(i,n) = x(i,n) + rand_gause(0.D0,1.D0)
	end do
end do


open(11,file='sec/lorenz96_rk4_obs.txt')
do n = 1,NN,1
	do i = 1,40
		write(11,'(f15.10)',advance='no') x(i,n)
	end do
		write(11,'()')
		write(6,*) n, x(1,n)
end do
close(11)

stop

contains
	real function rand_gause(mu,sigma)
		use mt19937_64
		implicit none
		real(real64)  mu, sigma,r1,r2,z1,z2
		r1 = genrand64_real3()
		r2 = genrand64_real3()
    z1=sqrt(-2.0*log(r1)) * sin(2.D0*PI*r2)
    z2=sqrt(-2.0*log(r1)) * cos(2.D0*PI*r2)
		rand_gause = mu + sigma*(z1 * z2)
  return
end function



end program make_obs
