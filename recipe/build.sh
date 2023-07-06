#!/bin/bash

set -xe

# Remove some files that may cause static linking?
rm -rfv $PREFIX/lib/objects*

mkdir build
cd build

if [[ ! -z "$mpi" && "$mpi" == "mpi_serial" ]]; then
  export USE_MPI_SERIAL="ON"
else
  export USE_MPI_SERIAL="OFF"
fi

# for cross compiling using openmpi
export OPAL_PREFIX=$PREFIX

cmake \
    ${CMAKE_ARGS} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DBUILD_SHARED_LIBS:BOOL=ON \
    -DPIO_USE_MALLOC:BOOL=ON \
    -DPIO_ENABLE_TOOLS:BOOL=OFF \
    -DPIO_ENABLE_TESTS:BOOL=OFF \
    -DPIO_ENABLE_EXAMPLES:BOOL=OFF \
    -DPIO_ENABLE_TIMING:BOOL=OFF \
    -DWITH_PNETCDF:BOOL=ON \
    -DPIO_USE_MPISERIAL:BOOL=${USE_MPI_SERIAL} \
    ${SRC_DIR}

cmake --build .

# make tests
# ctest

cmake --install .
