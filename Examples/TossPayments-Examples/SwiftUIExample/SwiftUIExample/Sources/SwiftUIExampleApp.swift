//
//  SwiftUIExampleApp.swift
//  SwiftUIExample
//
//  Created by 김진규 on 2022/09/27.
//

#if canImport(SwiftUI) && !os(macOS)
import SwiftUI

@main
struct SwiftUIExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

#endif
