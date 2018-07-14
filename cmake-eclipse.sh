#!/bin/bash

project=${PWD##*/}


mkdir ../${project}_eclipse
cd ../${project}_eclipse

cmake -G"Eclipse CDT4 - Unix Makefiles" \
      -DCMAKE_ECLIPSE_VERSION=4.6 \
      -DCMAKE_ECLIPSE_GENERATE_SOURCE_PROJECT=TRUE \
      -DCMAKE_CXX_COMPILER_ARG1=-std=c++1z \
      -DCMAKE_BUILD_TYPE=Debug \
      ../${project}
       
#      -DCMAKE_ECLIPSE_MAKE_ARGUMENTS=-j8 \
#      -DCMAKE_C_COMPILER=/usr/bin/gcc \
#      -DCMAKE_CXX_COMPILER=/usr/bin/g++ \
#      -DCMAKE_C_COMPILER=/usr/bin/clang \
#      -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \

