//
//  Language.swift
//  Bingpaper
//
//  Created by zm on 2022/1/18.
//

import SwiftUI

enum Language: String, CaseIterable {
    case system, chinese, english

    var locale: Locale {
        switch self {
        case .chinese: return .zh
        case .english: return .en
        default: return .current
        }
    }

    var title: LocalizedStringKey {
        switch self {
        case .chinese: return L10n.Language.chinese
        case .english: return L10n.Language.english
        default: return L10n.Language.system
        }
    }
}
