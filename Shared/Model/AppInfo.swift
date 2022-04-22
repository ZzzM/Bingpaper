//
//  AppInfo.swift
//  Bingpaper
//
//  Created by zm on 2021/12/30.
//

import Foundation


struct AppInfo {

    private enum InfoKey: String {
        case build = "CFBundleVersion",
             version = "CFBundleShortVersionString",
             identifier = "CFBundleIdentifier",
             name = "CFBundleName",
             firToken = "FIR_CLI_API_TOKEN",
             commitHash = "CommitHash",
             commitDate = "CommitDate"

    }

    private static func value(for key: InfoKey) -> String { Bundle.main.infoDictionary?[key.rawValue] as? String ?? "none" }

    static let name = value(for: .name)
    static let version = value(for: .version)
    static let id = value(for: .identifier)
    static let firToken = value(for: .firToken)
    static let commitHash = value(for: .commitHash)
    static let commitDate = value(for: .commitDate)

}
