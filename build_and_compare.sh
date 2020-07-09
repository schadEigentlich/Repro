#!/bin/bash
if [[ $1 = "custom" ]]; then
   TOOLCHAIN="TEST.20200623"
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
