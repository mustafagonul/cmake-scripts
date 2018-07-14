#!/bin/bash

project=${PWD##*/}


mkdir ../${project}_release
cd ../${project}_release

cmake -DCMAKE_BUILD_TYPE=Release \
      ../${project}

#      -DCMAKE_C_COMPILER=/usr/bin/gcc \
#      -DCMAKE_CXX_COMPILER=/usr/bin/g++ \
#      -DCMAKE_C_COMPILER=/usr/bin/clang \
#      -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \


