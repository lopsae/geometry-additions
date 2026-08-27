// swift-tools-version: 6.2


import PackageDescription


let package = Package(
    name: "GeometryAdditions",
    platforms: [
        .iOS(.v26),
        .macOS(.v26)
    ],
    products: [
        .library(
            name: "GeometryAdditions",
            targets: ["GeometryAdditions"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "GeometryAdditions",
            path: "sources",
            resources: []
        ),
        .testTarget(
            name: "UnitTests",
            dependencies: [
                "GeometryAdditions",
            ],
            path: "tests",
            exclude: [
                "UnitTests.xctestplan",
            ]
        )
    ]
)


// Target settings.
for target in package.targets {
    var settings = target.swiftSettings ?? []
    settings.append(contentsOf: [
        .defaultIsolation(nil),

        // https://github.com/swiftlang/swift-evolution/blob/main/proposals/0461-async-function-isolation.md
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),

        // https://github.com/swiftlang/swift-evolution/blob/main/proposals/0470-isolated-conformances.md
        .enableUpcomingFeature("InferIsolatedConformances"),

        // https://github.com/swiftlang/swift-evolution/blob/main/proposals/0409-access-level-on-imports.md
        .enableUpcomingFeature("InternalImportsByDefault")
    ])
    target.swiftSettings = settings
}
