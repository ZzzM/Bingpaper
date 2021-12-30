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
    private var pref = Preference()


    init() {
        
        let bar = UINavigationBar.appearance()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .systemBackground
        appearance.setBackIndicatorImage(UIImage.backward,
                                         transitionMaskImage: UIImage.backward)
        bar.standardAppearance = appearance
        bar.scrollEdgeAppearance = appearance

    }

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.font, .default)
                .tint(pref.palette.color)
                .accentColor(pref.palette.color)
                .environmentObject(pref)
                .preferredColorScheme(pref.theme.colorScheme)
                .onChange(of: pref.palette, perform: reloadTimelines)
                .onOpenURL(perform: onOpenURL)
                
        }
    }

    func reloadTimelines(_ palette: Palette) {
        WidgetCenter.shared.reloadAllTimelines()
    }

    func onOpenURL(_ url: URL) {
        guard url.scheme == URLScheme.default else { return }
        NotificationCenter.default.post(name: .sceneWillPresent, object: Paper(widgetURL: url))
    }
}

