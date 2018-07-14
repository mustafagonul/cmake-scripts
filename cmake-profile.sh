#!/bin/bash

project=${PWD##*/}


mkdir ../${project}_profile
cd ../${project}_profile

cmake -DCMAKE_BUILD_TYPE=Profile \
      ../${project}

#      -DCMAKE_C_COMPILER=/usr/bin/gcc \
#      -DCMAKE_CXX_COMPILER=/usr/bin/g++ \
#      -DCMAKE_C_COMPILER=/usr/bin/clang \
#      -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \


