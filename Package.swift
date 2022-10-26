// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SwiftSimplify",
    products: [
        .library(name: "SwiftSimplify", targets: ["SwiftSimplify"])
    ],
    targets: [
        .target(name: "SwiftSimplify"),
        .testTarget(name: "SwiftSimplifyTests", dependencies: ["SwiftSimplify"], resources: [.copy("SimplifyTestPoints.json")])
    ]
)
