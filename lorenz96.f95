program lorenz96
implicit none

integer,parameter:: NN = 140
real,parameter:: dt = 0.01
real, dimension(1:40,1:NN):: x,dx
real, dimension(1:NN) :: dxbar
real F,k0,k1,k2,k3,x1,x2,x3,ddx,x0
integer i, n, t
character(len=80) filename

F = 8.D0

do i=1,40
	x(i,1) = 0.0
	dx(i,1) = 0.0
end do

!set initial value
open (17, file='initial.txt', status='old')
  !read (17, '()')       ! ヘッダ行の読み飛ばし
  do i = 1, 40
    read (17, *) x0
		x(i,1) = x0
  end do
close (17)

t = 0

do n = 1,NN-1
	dx(1,n) = (x(2,n) - x(39,n)) * x(40,n) - x(1,n) + F
	dx(2,n) = (x(3,n) - x(40,n)) * x(1,n) - x(2,n) + F
	dx(40,n) = (x(1,n) - x(38,n)) * x(39,n) - x(40,n) + F

	!Runge-Kutta
	k0=dx(1,n)
	x1=x(1,n)+k0*dt/2;
	k1=2*x1;
	x2=x(1,n)+k1*dt/2;
	k2=2*x2;
	x3=x(1,n)+k2*dt;
	k3=2*x3;
	ddx = dt*(k0 + 2*k1 + 2*k2 + k3)/6;
	x(1,n+1)=x(1,n)+ddx;
	k0=dx(2,n)
	x1=x(2,n)+k0*dt/2;
	k1=2*x1;
	x2=x(2,n)+k1*dt/2;
	k2=2*x2;
	x3=x(2,n)+k2*dt;
	k3=2*x3;
	ddx = dt*(k0 + 2*k1 + 2*k2 + k3)/6;
	x(2,n+1)=x(2,n)+ddx;
	k0=dx(40,n)
	x1=x(40,n)+k0*dt/2;
	k1=2*x1;
	x2=x(40,n)+k1*dt/2;
	k2=2*x2;
	x3=x(40,n)+k2*dt;
	k3=2*x3;
	ddx = dt*(k0 + 2*k1 + 2*k2 + k3)/6;
	x(40,n+1)=x(40,n)+ddx;

		do i = 3,39
			dx(i,n) = (x(i+1,n) - x(i-2,n)) * x(i-1,n) - x(i,n) + F
			!x(i,n+1) = x(i,n) + dx(i,n)*dt

				!Runge-Kutta
				k0=dx(i,n)
      	x1=x(i,n)+k0*dt/2;
      	k1=2*x1;
      	x2=x(i,n)+k1*dt/2;
      	k2=2*x2;
      	x3=x(i,n)+k2*dt;
      	k3=2*x3;
      	ddx = dt*(k0 + 2*k1 + 2*k2 + k3)/6;
      	x(i,n+1)=x(i,n)+ddx;
		end do

end do

do n = 1,NN
	dxbar(n) = 0.D0
	write(filename,'("sec/sec_",i3.3,".txt")') n
	open(11,file=filename)
	do i = 1,40
		dxbar(n) = dxbar(n) + dx(i,n)
		write(11,'(f8.5)',advance='no') x(i,n)
		write(11,'()')
		!write (6,'(f8.1)',advance='no') x(i,n)
		!write(6,'()')
	end do
		close(11)
		dxbar(n) = dxbar(n) / 40
		write(6,*) n, abs(dxbar(n) / dxbar(1))

end do

stop
end program lorenz96
