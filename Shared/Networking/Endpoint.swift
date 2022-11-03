//
//  Endpoint.swift
//  Bingpaper
//
//  Created by zm on 2021/10/25.
//

import Foundation


enum Host {
    static let bing = "https://cn.bing.com"
    static let fir = "https://api.bq04.com"
}

enum Endpoint {
    case fetchPapers(String, String),
         checkForUpdate
}

extension Endpoint {

    private var host: String {
        if case .checkForUpdate = self {
            return Host.fir
        } else {
            return Host.bing
        }
    }

    private var path: String {
        if case .checkForUpdate = self {
            return "/apps/latest/" + AppInfo.id
        } else {
            return "/HPImageArchive.aspx"
        }
    }

    private var parameters: [String: String] {
        switch self {
        case .fetchPapers(let size, let mkt):
            return ["format": "js", "idx": "0", "n": size, "mkt": mkt]
        case .checkForUpdate:
            return ["api_token": AppInfo.firToken, "type": "ios"]
        }
    }

    var logged: Bool {
        if case .checkForUpdate = self {
            return false
        } else {
            return false
        }
    }

    var url: URL? {
        guard var components = URLComponents(string: host)  else {
            return .none
        }
        components.path = path
        components.setQueryItems(parameters)
        return components.url
    }
}
