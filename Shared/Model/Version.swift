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

        isLatest = AppInfo.version == version ? AppInfo.build == build : false

        changelog = "\(version)( \(build) )" + "\n" + _changelog

        let _installUrl = try container.decode(String.self, forKey: .installUrl)
        installUrl = "itms-services://?action=download-manifest&url=" + _installUrl.urlEncoded

    }

}
