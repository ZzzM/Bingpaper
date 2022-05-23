//
//  AppInfo.swift
//  Bingpaper
//
//  Created by zm on 2021/12/30.
//

import Foundation


enum AppInfoKey: String {
    case build = "CFBundleVersion",
         version = "CFBundleShortVersionString",
         identifier = "CFBundleIdentifier",
         name = "CFBundleName",
         firToken = "FIR_CLI_API_TOKEN",
         gitHash = "GIT_HASH",
         gitDate = "GIT_DATE"
}

struct AppInfo {

    private static subscript(key: AppInfoKey) -> String {
        Bundle.main.infoDictionary?[key.rawValue] as? String ?? "none"
    }

    static let name = Self[.name]
    static let version = Self[.version]
    static let gitHash = Self[.gitHash]
    static let gitDate = Self[.gitDate]

    static let id = Self[.identifier]
    static let firToken = Self[.firToken]

}
