program main
implicit none
include 'mpif.h'
integer :: i
integer, parameter :: nx=10
integer :: ierr,nprocs,myrank,info,win
integer(kind=MPI_ADDRESS_KIND):: size
integer(kind=MPI_ADDRESS_KIND):: tdisp
integer(2) :: ff(1:2*nx)

call mpi_init(ierr)
call mpi_comm_size(mpi_comm_world,nprocs,ierr)
call mpi_comm_rank(mpi_comm_world,myrank,ierr)

!initialize
do i=1,20
  if (myrank == 0 ) then
  ff(i) = 1
        else
  ff(i) = 2
  endif
enddo


    write(6, '("start myrank ="I0":")') myrank
    write(6,'(20i0)') ff(1:2*nx)
size = 40
info = MPI_INFO_NULL
  call mpi_win_create(ff(1),size,2,info,mpi_comm_world,win,ierr)

  call mpi_win_fence(0, win, ierr )

if (myrank == 0 ) then
  tdisp = 0
  call mpi_get(ff(nx+1), 10, mpi_integer2,1, tdisp, 10, mpi_integer2,win, ierr )
  tdisp = 10
  call mpi_put(ff(1), 10, mpi_integer2,1, tdisp, 10, mpi_integer2,win, ierr )

endif

  call mpi_win_fence(0,win,ierr)
  call mpi_win_free( win, ierr )

    write(6, '("end myrank ="I0":")') myrank
    write(6,'(20i0)') ff(1:2*nx)

call mpi_finalize(ierr)

end
