#!/bin/bash

# Debugging
# set -x

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
LIGHT_RED='\e[1;31m'
LIGHT_BLUE='\033[1;34m'
LIGHT_GREEN='\033[1;32m'
NC='\033[0m' # No Color

# Functions
print_help () {
  echo -e "${GREEN}Command:${NC}"
  echo -e "cmake-eclipse.sh --build-type | -b <Debug | Release> --compiler | -c <Gcc | Clang> --path | -p <PATH>"
  echo -e "cmake-eclipse.sh --help | -h"
  echo
  echo -e "${GREEN}Defaults:${NC}"
  echo -e "Build Type: Debug"
  echo -e "Compiler:   Gcc"
  echo -e "Path:       ${PWD}"

  exit
}

# Default Parameters
BUILD_TYPE="debug"
COMPILER="gcc"
PROJECT_PATH=$PWD

# Parameters
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -b|--build-type)
    BUILD_TYPE="$2"
    shift # past argument
    shift # past value
    ;;

    -c|--compiler)
    COMPILER="$2"
    shift # past argument
    shift # past value
    ;;

    -p|--path)
    PROJECT_PATH="$2"
    shift # past argument
    shift # past value
    ;;

    -h|--help)
    print_help
    ;;

    *)    # unknown option
    print_help
    ;;
esac
done

## Parameter translation

# BUILD_TYPE="$(echo $BUILD_TYPE | tr [:upper:] [:lower:])"
BUILD_TYPE=${BUILD_TYPE,,}

# COMPILER="$(echo $COMPILER | tr [:upper:] [:lower:])"
COMPILER=${COMPILER,,}

# Empty parameter check
if [[ -z $BUILD_TYPE ]]; then
    print_help
fi

if [[ -z $COMPILER ]]; then
    print_help
fi

if [[ -z $PROJECT_PATH ]]; then
    print_help
fi


## Parameter preparation

# Project
PROJECT=${PROJECT_PATH##*/}

if [[ -z $PROJECT ]]; then
    echo -e "${RED}Project name is empty!${NC}"
    exit 1
fi

if [[ ! -f "$PROJECT_PATH/CMakeLists.txt" ]]; then
    echo -e "${RED}CMakeLists.txt cannot be found!${NC}"
    exit 1
fi

# Eclipse project
ECLIPSE_PROJECT_PATH=$(realpath ${PROJECT_PATH}/../${PROJECT}_eclipse)

# Build type
case $BUILD_TYPE in
    release)
    BUILD_TYPE="Release"
    ;;

    debug)
    BUILD_TYPE="Debug"
    ;;

    *)
    echo -e "${RED}Invalid build type${NC}"
    exit 1
esac

# Compiler
case $COMPILER in
    gcc)
    COMPILER="GNU/GCC"
    C_COMPILER="$(which gcc)"
    CXX_COMPILER="$(which g++)"
    ;;

    clang)
    COMPILER="Clang"
    C_COMPILER="$(which clang)"
    CXX_COMPILER="$(which clang++)"
    ;;

    *)
    echo -e "${RED}Invalid compiler${NC}"
    exit 1
    ;;
esac

if [[ -z $C_COMPILER ]]; then
    echo -e "${RED}No C compiler!${NC}"
    exit 1
fi

if [[ -z $CXX_COMPILER ]]; then
    echo -e "${RED}No C++ compiler!${NC}"
    exit 1
fi


## Printing parameters and values
echo -e
echo -e "${BLUE}Project:${NC}      ${PROJECT}"
echo -e "${BLUE}Path:${NC}         ${PROJECT_PATH}"
echo -e "${BLUE}Eclipse:${NC}      ${ECLIPSE_PROJECT_PATH}"
echo -e "${BLUE}Build type:${NC}   ${BUILD_TYPE}"
echo -e "${BLUE}Compiler:${NC}     ${COMPILER}"
echo -e "${BLUE}C Compiler:${NC}   ${C_COMPILER}"
echo -e "${BLUE}C++ Compiler:${NC} ${CXX_COMPILER}"
echo -e


## Eclipse project creation

# Removing old directory
rm -Rf $ECLIPSE_PROJECT_PATH

# Creating separate directory
mkdir $ECLIPSE_PROJECT_PATH
cd $ECLIPSE_PROJECT_PATH

# CMake
cmake -G"Eclipse CDT4 - Unix Makefiles"            \
      -DCMAKE_ECLIPSE_VERSION=4.6                  \
      -DCMAKE_ECLIPSE_GENERATE_SOURCE_PROJECT=TRUE \
      -DCMAKE_CXX_COMPILER_ARG1=-std=c++1z         \
      -DCMAKE_BUILD_TYPE=${BUILD_TYPE}             \
      -DCMAKE_C_COMPILER=${C_COMPILER}             \
      -DCMAKE_CXX_COMPILER=${CXX_COMPILER}         \
      $PROJECT_PATH

#      -DCMAKE_ECLIPSE_MAKE_ARGUMENTS=-j8 \
#      -DCMAKE_C_COMPILER=/usr/bin/gcc \
#      -DCMAKE_CXX_COMPILER=/usr/bin/g++ \
#      -DCMAKE_C_COMPILER=/usr/bin/clang \
#      -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \

