//
//  L10n.swift
//  Bingpaper
//
//  Created by zm on 2022/1/18.
//

import SwiftUI

struct L10n {

    private static var locale: Locale { Preference.shared.locale }

    private static var inChinese: Bool { locale.identifier.contains("zh") }

    private static let formatter = DateFormatter()

    enum Settings {
        static let title = "settings.title".l10nKey
        static let general = "settings.general".l10nKey
        static let other = "settings.other".l10nKey
        static let theme = "settings.theme".l10nKey
        static let palette = "settings.palette".l10nKey
        static let language = "settings.language".l10nKey
        static let clear = "settings.clear".l10nKey
        static let permission = "settings.permission".l10nKey
        static let changelogs = "settings.changelogs".l10nKey
        static let licenses = "settings.licenses".l10nKey
        static let newVersion = "settings.newVersion".l10nKey

    }
    enum Theme {
        static let system = "theme.system".l10nKey
        static let dark = "theme.dark".l10nKey
        static let light = "theme.light".l10nKey
    }
    enum Permission {
        static let addPhotos = "permission.addPhotos".l10nKey
    }

    enum Language {
        static let system = "language.system".l10nKey
        static let chinese = "language.chinese".l10nKey
        static let english = "language.english".l10nKey
    }

    enum Alert {
        static let ok = "alert.ok".l10nKey
        static let cancel = "alert.cancel".l10nKey
        static let confirmPermission = "alert.confirm.permission".l10nKey
        static let requestPermission = "alert.request.permission".l10nKey
        static let install = "alert.install".l10nKey
        static let clear = "alert.clear".l10nKey
    }

    enum Error {
        static let reload = "error.reload".l10nKey
        static let empty = "error.empty".l10nKey
        static let url = "error.url".l10nString
        static let http = "error.http".l10nString
        static let server = "error.server".l10nString
    }

    enum Toast {
        static let refreshCompleted = "toast.refresh.completed"
        static let refreshFailed = "toast.refresh.failed"
        static let albumCompleted = "toast.album.completed"
        static let albumFailed = "toast.album.failed"
    }

}

extension L10n {
    static var languageCode: String? { locale.languageCode }
    static var mkt: String { inChinese ? "zh-CN":"en-US" }
    static var changlogs: String { "https://github.com/ZzzM/Bingpaper/blob/master/changelogs/" + (inChinese ? "CHANGELOG_SC":"CHANGELOG") + ".md" }
}

extension L10n {

    static func month(from date: Date = Date()) -> String {
        formatter.locale = locale
        return formatter.monthSymbols[date.month - 1]
    }

    static func shortWeekday(from date: Date = Date()) -> String {
        formatter.locale = locale
        return  formatter.shortWeekdaySymbols[date.weekday - 1]
    }


    static func veryShortWeekday(from date: Date = Date()) -> String {
        formatter.locale = locale
        return  formatter.veryShortWeekdaySymbols[date.weekday - 1]
    }

}
extension String {
    var l10nKey: LocalizedStringKey {
        LocalizedStringKey(self)
    }

    var l10nString: String? {
        guard let path = Bundle.main.path(forResource: L10n.languageCode, ofType: "lproj"),
                let bundle = Bundle(path: path) else {
            return .none
        }
        return NSLocalizedString(self, bundle: bundle, comment: "")
    }
}
