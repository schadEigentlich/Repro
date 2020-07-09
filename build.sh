#!/bin/bash
DATE=$(date +%y%m%d-%H%M%S)
mkdir -p build > /dev/null
./run_build.sh $1 > build/build.log
mv build builds/$DATE > /dev/null
echo $DATE
