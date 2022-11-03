//
//  BingpaperApp.swift
//  Bingpaper
//
//  Created by zm on 2021/10/26.
//

import SwiftUI
import WidgetKit


@main
struct BingpaperApp: App {

    @StateObject
    private var pref = Preference.shared

    var body: some Scene {
        WindowGroup {
            
            MainView()
                .environmentObject(pref)
                .environment(\.font, .default)
                .tint(.primary)
                .accentColor(.primary)
                .preferredColorScheme(pref.colorScheme)
                .onOpenURL(perform: onOpenURL)

        }
    }

    func onOpenURL(_ url: URL) {
        guard url.scheme == URLScheme.default else { return }
        NotificationCenter.default.post(name: .sceneWillPresent, object: url)
    }
}

