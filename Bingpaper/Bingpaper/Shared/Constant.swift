//
//  Constants.swift
//  Bingpaper
//
//  Created by zm on 2021/10/26.
//

import SwiftUI


typealias VoidClosure = () -> Void
typealias FailureClosure = (Error) -> Void

enum AppStorageKey {
    static let theme = "AppStorageKey.theme"
    static let palette = "AppStorageKey.palette"
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

enum AppInfo {
    static let id = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String ?? "AppId"
    static let name = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "AppName"
    static let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ??  "AppVersion"
    static let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ??  "AppBuild"
}

enum WidgetInfo {
    static let kind = "bingpaper.widget"
    static let displayName = "Bing 壁纸日历"
    static let description = "一个显示 Bing 壁纸和日历的小组件"
}

enum URLScheme {
    static let `default` = "Bingpaper"
}


extension UIImage {
    static let backward = UIImage(systemName: "arrow.backward")
}

extension Image {
    static let settings = Image(systemName: "gearshape.fill")
}

extension Color {
    static let appBackground = Color("AppBackground")
    static let cellBackground = Color("CellBackground")
}

extension Font {
    static let `default` = Font.system(size: 16, weight: .light, design: .rounded)
}

extension Locale {
    static let `default` = Locale(identifier: "zh")
}

extension Calendar {
    static var `defatult`: Calendar {
        var calendar = Calendar.current
        calendar.locale = .default
        return calendar
    }
}

extension DateFormatter {
    static var `default`: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.default
        return dateFormatter
    }
}

extension Array where Element == (Int, String) {
    static let weekdaySymbols = Calendar.defatult.veryShortWeekdaySymbols.enumerated() + []
}

extension Array where Element == GridItem {
    static let weekdayColumns = [GridItem](repeating: .init(.adaptive(minimum: 15, maximum: 17)), count: 7)
}
