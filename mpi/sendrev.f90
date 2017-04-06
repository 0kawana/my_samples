program main
implicit none
include 'mpif.h'
integer :: i
integer, parameter :: nx=10
integer :: reqsend(1),reqrecv(1)
integer :: statsend(MPI_STATUS_SIZE,1), statrecv(MPI_STATUS_SIZE,1)
integer :: ierr,nprocs,myrank
integer :: ff(1:2*nx)
character(len=255) :: filename

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

!write before data_exchange
    write(6, '("start myrank ="I0":")') myrank
    write(6,'(20i0)') ff(1:2*nx)

  if (myrank == 0 ) then
  call mpi_irecv(ff(nx+1),10,mpi_integer,1,0,mpi_comm_world,reqrecv(1),ierr)
  call mpi_isend(ff(1),10,mpi_integer,1,0,mpi_comm_world,reqsend(1),ierr)
else
  call mpi_irecv(ff(nx+1),10,mpi_integer,0,0,mpi_comm_world,reqrecv(1),ierr)
  call mpi_isend(ff(1),10,mpi_integer,0,0,mpi_comm_world,reqsend(1),ierr)
endif
  call mpi_waitall(1, reqrecv, statrecv,ierr)
  call mpi_waitall(1, reqsend, statsend,ierr)

!write after data_exchange
    write(6, '("end myrank ="I0":")') myrank
    write(6,'(20i0)') ff(1:2*nx)

call mpi_finalize(ierr)

end
