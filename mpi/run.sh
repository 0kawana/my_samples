#!/bin/bash

#init
node=1
proc=2


#openmpi 1.5.4
mpif90 sendrev.f90
mpiexec -n $proc ./a.out
