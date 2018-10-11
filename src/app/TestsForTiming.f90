    !MARETEC - Research Centre for Marine, Environment and Technology
    !Copyright (C) 2018  Ricardo Birjukovs Canelas
    !
    !This program is free software: you can redistribute it and/or modify
    !it under the terms of the GNU General Public License as published by
    !the Free Software Foundation, either version 3 of the License, or
    !(at your option) any later version.
    !
    !This program is distributed in the hope that it will be useful,
    !but WITHOUT ANY WARRANTY; without even the implied warranty of
    !MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    !GNU General Public License for more details.
    !
    !You should have received a copy of the GNU General Public License
    !along with this program.  If not, see <https://www.gnu.org/licenses/>.


    program TestsForTimming

    use timer_mod

    implicit none

    type(timer_class) :: simpleTimer, parallelTimer
    integer :: n = 20000
    integer :: i, j
    integer, allocatable, dimension(:,:) :: a, b


    allocate(a(n,n))
    allocate(b(n,n))

    call simpleTimer%initialize()
    call simpleTimer%Tic()
    do i=1, size(b,1)
        do j=1, size(b,2)
            a(i,j) = b(i,j)
        end do
    end do
    call simpleTimer%Toc()    
    call simpleTimer%print()
    
    call parallelTimer%initialize()
    call parallelTimer%Tic()
    !$OMP PARALLEL DO
    do i=1, size(b,1)
        do j=1, size(b,2)
            a(i,j) = b(i,j)
        end do
    end do
    !$OMP END PARALLEL DO
    call parallelTimer%Toc()    
    call parallelTimer%print()

    end program TestsForTimming
