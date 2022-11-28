#!/bin/bash

set -xe

# Remove some files that may cause static linking?
rm -rfv $PREFIX/lib/objects*

mkdir build
cd build

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
    -DWITH_PNETCDF:BOOL=OFF \
    ${SRC_DIR}

cmake --build .

# make tests
# ctest

cmake --install .

(exit 1)
