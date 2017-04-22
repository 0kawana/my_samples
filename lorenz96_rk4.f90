program lorenz96_rk4
implicit none

integer,parameter:: NN = 1400
real,parameter:: dt = 0.05D0, F = 8.D0
real, dimension(1:40,1:NN):: x,dx
real, dimension(1:NN) :: dxbar,hx
real xini
integer i, n, t
character(len=80) filename

do i=1,40
	x(i,1) = 0.0
	dx(i,1) = 0.0
end do

!set initial value
open (17, file='initial.txt', status='old')
  do i = 1, 40
    read (17, *) xini
		x(i,1) = xini
  end do
close (17)

t = 0

do n = 1,NN-1

	call runge_kutta(x(:,n))
	do i = 1,40
	dx(i,n) = hx(i)
	end do
	x(:,n+1)=x(:,n) + dx(:,n)

end do


write(filename,'("sec/sec_",i3.3,".txt")') 1
open(11,file=filename)
do n = 1,NN
	dxbar(n) = 0.D0
	do i = 1,40
		dxbar(n) = dxbar(n) + abs(dx(i,n))
		write(11,'(f12.7)',advance='no') x(i,n)
	end do
		write(11,'()')
		dxbar(n) = dxbar(n) / 40
		write(6,*) n, abs(dxbar(n) / dxbar(1))
		!write(6,*) n, dxbar(n)
end do
close(11)

stop


contains
	!real Lorenz'96 calculation
	subroutine lorenz96(xin)
	implicit none
	real xin(1:40)
	hx(1) = (xin(2) - xin(39)) * xin(40) - xin(1) + F
	hx(2) = (xin(3) - xin(40)) * xin(1) - xin(2) + F
		do i = 3,39
			hx(i) = (xin(i+1) - xin(i-2)) * xin(i-1) - xin(i) + F
		end do
	hx(40) = (xin(1) - xin(38)) * xin(39) - xin(40) + F
	end subroutine


	!Runge-Kutta
	subroutine runge_kutta(xin)
    implicit none
		real ,dimension(1:NN) :: xin,k1,k2,k3,k4,x1,x2,x3,x4

		x1(:) = xin(:)
		call lorenz96(x1(:))
		k1(:) = hx(:)

		x2(:) = xin(:) + dt / 2 * k1
		call lorenz96(x2(:))
		k2(:) = hx(:)

		x3(:) = xin(:) + dt / 2 * k2
		call lorenz96(x3(:))
		k3(:) = hx(:)

		x4(:) = xin(:) + dt * k3
		call lorenz96(x4(:))
		k4(:) = hx(:)

		hx(:) = dt * (k1(:) + 2*k2(:) + 2*k3(:) + k4(:))/6;
		return
	end subroutine runge_kutta

end program lorenz96_rk4
