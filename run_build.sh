#!/bin/bash
if [[ $1 != "" ]]; then
   TOOLCHAIN="-toolchain TEST.20200623"
fi 

xcodebuild -project Repro.xcodeproj $TOOLCHAIN -scheme 'Repro' -destination 'generic/platform=iOS' -archivePath ./build/archive.xarchive -derivedDataPath  './build/deriveddata' clean archive
