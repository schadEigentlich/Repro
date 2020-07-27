#!/bin/bash
export ZERO_AR_DATE=1
if [[ $1 = "custom" ]]; then
   TOOLCHAIN="org.swift.50202007221a"
elif [[ $1 = "default" ]]; then
   TOOLCHAIN=""
else
   echo "Usage: build_and_compare.sh <custom|default>"
   exit
fi

echo "1st Build"
BUILD_A=$(./build.sh $TOOLCHAIN)
echo "2nd Build"
BUILD_B=$(./build.sh $TOOLCHAIN)
echo "Comparison"
./test.sh $BUILD_A $BUILD_B
