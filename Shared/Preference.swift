//
//  Preferences.swift
//  Bingpaper
//
//  Created by zm on 2021/10/26.
//
import SwiftUI

class Preference: ObservableObject {

    static let shared = Preference()

    @AppStorage(AppStorageKey.theme)
    var theme: Theme = .system

    @AppStorage(AppStorageKey.language)
    var language: Language = .system

    @AppStorage(AppStorageKey.isGrid)
    var isGrid = false
}

extension Preference {
    var colorScheme: ColorScheme? { theme.colorScheme }
    var locale: Locale { language.locale }
    var columns: [GridItem] { Array(repeating: GridItem(), count: isGrid ? 2:1) }
}
