//
//  AppInfo.swift
//  Bingpaper
//
//  Created by zm on 2021/12/30.
//

import Foundation


enum AppInfo: String {

    case firToken = "FIR_CLI_API_TOKEN",
         build = "CFBundleVersion",
         version = "CFBundleShortVersionString",
         identifier = "CFBundleIdentifier"

    var value: String {
        Bundle.main.infoDictionary?[rawValue] as? String ?? "Nil"
    }

}
