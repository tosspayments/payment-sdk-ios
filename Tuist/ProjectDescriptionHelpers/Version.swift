//
//  Version.swift
//  TossPayments-ExamplesManifests
//
//  Created by 김진규 on 2022/10/13.
//


import ProjectDescription
import Foundation

public struct Version {
    public static var current: SettingValue {
        if let versionPath = Path.relativeToCurrentFile("").callerPath?
            .replacingOccurrences(
                of: "Version.swift",
                with: "../../version"
            ) {
            do {
                let version = try String(contentsOfFile: versionPath)
                return "\(version.trimmingCharacters(in: .whitespacesAndNewlines))"
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        return "0.0.1"
    }
}
