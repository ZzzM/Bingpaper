//
//  Version.swift
//  Bingpaper
//
//  Created by zm on 2021/11/10.
//

import Foundation

struct Version: Decodable {

    let name: String
    let changelog: String
    let isLatest: Bool
    let installUrl: String

    enum CodingKeys: CodingKey {
        case name, installUrl, changelog, versionShort, build
    }

    init() {
        name = ""
        changelog = ""
        installUrl = ""
        isLatest = true
    }


    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        let _changelog = try container.decodeIfPresent(String.self, forKey: .changelog) ?? ""

        let version = try container.decode(String.self, forKey: .versionShort)
        let build = try container.decode(String.self, forKey: .build)
        isLatest = Version.compare(version: version, build: build) >= 0


        changelog = "\(version)( \(build) )" + "\n" + _changelog


        let _installUrl = try container.decode(String.self, forKey: .installUrl)
        installUrl = "itms-services://?action=download-manifest&url=" + _installUrl.urlEncoded

    }

    /// v1 > v2 -> 1
    /// v1 < v2 -> -1，
    /// 无法比较 -> 0
    private static func compare(version: String, build: String) -> Int {
        var a1 = AppInfo.version.split(separator:"."),
            a2 = version.split(separator:".")

        let count = max(a1.count, a2.count)
        for _ in 0 ..< count {
            let num1 = a1.isEmpty ? 0: Int(a1.removeFirst()) ?? 0,
                num2 = a2.isEmpty ? 0:  Int(a2.removeFirst()) ?? 0
            guard num1 != num2  else { continue }
            return num1 > num2 ? 1:-1
        }

        let b1 = Int(AppInfo.build) ?? 0,
            b2 = Int(build) ?? 0

        guard b1 != b2 else  {  return 0 }
        return b1 > b2 ? 1:-1

    }
}
