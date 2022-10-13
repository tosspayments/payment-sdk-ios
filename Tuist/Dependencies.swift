//
//  Dependencies.swift
//  Config
//
//  Created by 김진규 on 2022/10/13.
//

import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: [
        .local(path: .relativeToRoot("./"))
    ],
    platforms: [.iOS]
)
