//
//  Constants.swift
//  Bingpaper
//
//  Created by zm on 2021/10/26.
//

import SwiftUI


typealias VoidClosure = () -> Void
typealias FailureClosure = (Error) -> Void



let DaysInWeek =  7, MinDates = 35, MaxDates = 42

enum AppStorageKey {
    static let theme = "AppStorageKey.theme"
    static let palette = "AppStorageKey.palette"
    static let language = "AppStorageKey.language"
}

extension Calendar {
    static let gregorian = Calendar(identifier: .gregorian)
    static let chinese = Calendar(identifier: .chinese)
}

extension Locale {
    static let en = Locale(identifier: "en")
    static let zh = Locale(identifier: "zh")
}

extension UserDefaults {
    static let `default` = UserDefaults(suiteName: "group.com.alpha.nw")
}

extension Notification.Name {
    static let sceneWillPresent = Notification.Name(rawValue: "sceneWillPresent")
}

extension NotificationCenter.Publisher {
    static let sceneWillEnterForeground = NotificationCenter.default.publisher(for: UIScene.willEnterForegroundNotification)
    static let sceneWillPresent = NotificationCenter.default.publisher(for: .sceneWillPresent, object: .none)
}

enum WidgetInfo {
    static let kind = "bingpaper.widget"
    static let displayName = "widget.displayName".l10nKey
    static let description = "widget.description".l10nKey
}

enum URLScheme {
    static let `default` = "Bingpaper"
}

extension URL {
    static let gitHub = URL(string: "https://github.com/ZzzM/Bingpaper")!
}


extension UIImage {
    static let backward = UIImage(systemName: "arrow.backward")
}

extension Image {
    static let settings = Image(systemName: "gearshape.fill")
    static let warning = Image(systemName: "exclamationmark.circle.fill")
    static let failure = Image(systemName: "xmark.circle.fill")
    static let success = Image(systemName: "checkmark.circle.fill")
    static let download = Image(systemName: "arrow.down")
    static let close = Image(systemName: "xmark")
    static let appLogo = Image.init("AppLogo", bundle: .main)
}

extension Color {
    static let appBackground = Color("AppBackground")
    static let cellBackground = Color("CellBackground")
}

extension Font {
    static let `default` = Font.system(size: 16, weight: .light, design: .rounded)
}




extension Array where Element == GridItem {
    static let weekdayColumns = [GridItem](repeating: .init(.adaptive(minimum: 15, maximum: 17)), count: 7)
}
