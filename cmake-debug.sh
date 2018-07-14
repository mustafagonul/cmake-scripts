#!/bin/bash

project=${PWD##*/}


mkdir ../${project}_debug
cd ../${project}_debug

cmake -DCMAKE_BUILD_TYPE=Debug \
      ../${project}

#      -DCMAKE_C_COMPILER=/usr/bin/clang \
#      -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \
#      -DCMAKE_C_COMPILER=/usr/bin/gcc \
#      -DCMAKE_CXX_COMPILER=/usr/bin/g++ \


