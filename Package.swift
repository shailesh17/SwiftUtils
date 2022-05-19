// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUtils",
    platforms: [
        // .macOS(.v10_14), 
        .iOS(.v14),
	// .tvOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SwiftUtils",
            targets: ["SwiftUtils",
                      // "SwiftUtilsRemoteBinaryPackage",
                      // "SwiftUtilsLocalBinaryPackage"
                     ]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SwiftUtils",
            dependencies: []
            // exclude: ["README.md"]
            // resources: [
            //     .process("text.txt"),
            //     .process("example.png"),
            //     .copy("settings.plist")
            // ]
        ),
//        .binaryTarget(
//            name: "SwiftUtilsRemoteBinaryPackage",
//            url: "https://url/to/some/remote/binary/package.zip",
//            checksum: "The checksum of the XCFramework inside the ZIP archive."
//        ),
//        .binaryTarget(
//            name: "SwiftUtilsLocalBinaryPackage",
//            path: "./dist/SwiftUtils.xcframework"
//        ),
        .testTarget(
            name: "SwiftUtilsTests",
            dependencies: ["SwiftUtils"]
        ),
    ]
)
