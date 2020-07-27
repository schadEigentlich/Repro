# Test Project for Reproducible Builds on iOS
This is a sample app, custom Swift toolchain and comparison tools to investigate reproducible builds for iOS apps. The root of the repository contains a simple iOS app which does nothing useful but has some dependencies added throught Swift Package Manager. The toolchain_patches directory contains patches for individual components of the Swift toolchain. The release section has prebuilt toolchains with these patches already applied. 

## Current Results
All builds were done with debug symbols and bitcode generation disabled in the project build settings.
### Default Toolchain
With the default toolchain, some object files differ by a large amount, e.g. `ZIPFoundation.o` differs by ~80% between builds. Some object files also differ slightly in file size.
```
200709-180814/deriveddata/Build/Intermediates.noindex/ArchiveIntermediates/Repro/IntermediateBuildFilesPath/ZIPFoundation.build/Release-iphoneos/ZIPFoundation.build/Objects-normal/armv7/Binary/ZIPFoundation.o
Sizes: 1174304 1174300, diff: 4
945727 of 1174300 bytes differ. 80.535382%
```

### Custom Toolchain
With the modified toolchain, the same files differ by less than 1%. All files have the exact same size.

```
200709-181422/deriveddata/Build/Intermediates.noindex/ArchiveIntermediates/Repro/IntermediateBuildFilesPath/ZIPFoundation.build/Release-iphoneos/ZIPFoundation.build/Objects-normal/armv7/Binary/ZIPFoundation.o
Sizes: 323120 323120, diff: 0
9 of 323120 bytes differ. 0.002785%
```

## Reproducibility on iOS
Buliding the same app twice on the same system results in functionally identical but different outputs.  
Two major factors in this are embedded bitcode and debug symbols.  
While both can be disabled project-wide (as is the case in this sample project), these settings are not respected when compiling dependencies added through Swift Package Manager. This can be observed by looking at the build process, where the `-embed_bitcode` and `-g` flags are always present for package sources, regardless of project settings. The included tools also show that object files compiled from package sources differ by up to 80% when compared side-by-side.

## Custom Swift Toolchain
To circumvent the flags enforced by SPM, a custom Swift toolchain is used which can be found [here](https://github.com/schadEigentlich/swift-reproducible-llvm). This toolchain contains a modified version of LLVM, which ignores the `-g` and `-embed_bitcode` flags. Building the project with this toolchain yields in much more similar object files (<1% difference). To build using this toolchain, the `swift-LOCAL-2020-06-23-a.xctoolchain` folder needs to be copied to `~/Library/Developer/Toolchains/`.

## Comparison tools

The `build_and_compare.sh` script builds the sample project twice and compares the resulting object files and the resulting binary. The script can be called with the `default` option which compiles the project with the system default toolchain, or with the `custom` option to use the included modified toolchain. The toolchain needs to be installed as described above.

### TELEGRAM ANALYSIS
This test uses a modified version of the binary comparison tool used by Telegram for verifying repeatable builds, documented [here](https://core.telegram.org/reproducible-builds#reproducible-builds-for-ios). It strips non-functional parts of the binary such as timestamps and signatures and compares the rest byte by byte.

### OBJECT COMPARISON
This test compares all .o files individually side-by-side using the included bindiff tool.

### OBJDUMP COMPARISON
This test compares the output of `objdump -full-contents -macho` for the resulting binary.

### BINDIFF COMPARISON
This test compares the resulting binaries using the included bindiff tool.



