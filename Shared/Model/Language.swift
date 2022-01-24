//
//  Language.swift
//  Bingpaper
//
//  Created by zm on 2022/1/18.
//

import SwiftUI

enum Language: String, CaseIterable {
    case system, chinese, english
    static let `default`: Language = .system

    var locale: Locale {
        switch self {
        case .chinese: return .init(identifier: "zh")
        case .english: return .init(identifier: "en")
        default: return .current
        }
    }

    var displayName: LocalizedStringKey {
        switch self {
        case .chinese: return L10n.Language.chinese
        case .english: return L10n.Language.english
        default: return L10n.Language.system
        }
    }

    var mkt: String {
        switch self {
        case .chinese: return "zh-CN"
        case .english: return "en-US"
        default: return Locale.current.identifier.contains("zh") ? "zh-CN":"en-US"
        }
    }

    var changlog: String {
        switch self {
        case .chinese: return "CHANGELOG_SC"
        case .english: return "CHANGELOG"
        default: return Locale.current.identifier.contains("zh") ? "CHANGELOG_SC":"CHANGELOG"
        }
    }
}
