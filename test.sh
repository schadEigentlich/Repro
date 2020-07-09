#!/bin/bash

BUILD_A="$1"
BUILD_B="$2"
BINARY="archive.xarchive.xcarchive/Products/Applications/Repro.app/Repro"
cd builds
echo "==========TELEGRAM ANALYSIS=========="
../telegram_compare "$BUILD_A/$BINARY" "$BUILD_B/$BINARY"

echo "==========OBJECT COMPARISON=========="
../compare_builds.sh $BUILD_A $BUILD_B

echo "=========OBJDUMP COMPARISON=========="
diff -q -s <(objdump -full-contents -macho $BUILD_A/$BINARY) <(objdump -full-contents -macho $BUILD_B/$BINARY) 

echo "=============BINDIFF================="
../bindiff/bindiff "$BUILD_A/$BINARY" "$BUILD_B/$BINARY"
