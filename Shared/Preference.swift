//
//  Preferences.swift
//  Bingpaper
//
//  Created by zm on 2021/10/26.
//
import SwiftUI

class Preference: ObservableObject {

    static let shared = Preference()

    @AppStorage(AppStorageKey.theme, store: UserDefaults.default)
    var theme: Theme = .system

    @AppStorage(AppStorageKey.palette, store: UserDefaults.default)
    var palette: Palette = .red

    @AppStorage(AppStorageKey.language, store: UserDefaults.default)
    var language: Language = .system
}
