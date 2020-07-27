#!/bin/bash
if [[ $1 != "" ]]; then
   TOOLCHAIN="-toolchain $1"
fi 

xcodebuild -project Repro.xcodeproj $TOOLCHAIN -scheme 'Repro' -destination 'generic/platform=iOS' -archivePath ./build/archive.xarchive -allowProvisioningUpdates -derivedDataPath  './build/deriveddata' SWIFTC_MAXIMUM_DETERMINISM=1  GCC_GENERATE_DEBUGGING_SYMBOLS=NO clean archive
