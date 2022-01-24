//
//  L10n.swift
//  Bingpaper
//
//  Created by zm on 2022/1/18.
//

import SwiftUI

struct L10n {

    enum Settings {
        static let title = "settings.title".localizedKey
        static let general = "settings.general".localizedKey
        static let other = "settings.other".localizedKey
        static let theme = "settings.theme".localizedKey
        static let palette = "settings.palette".localizedKey
        static let language = "settings.language".localizedKey
        static let cache = "settings.cache".localizedKey
        static let permission = "settings.permission".localizedKey
        static let about = "settings.about".localizedKey
        static let changelog = "settings.changelog".localizedKey
    }
    enum Theme {
        static let system = "theme.system".localizedKey
        static let dark = "theme.dark".localizedKey
        static let light = "theme.light".localizedKey
    }
    enum Permission {
        static let addPhotos = "permission.addPhotos".localizedKey
    }

    enum Language {
        static let system = "language.system".localizedKey
        static let chinese = "language.chinese".localizedKey
        static let english = "language.english".localizedKey
    }

    enum Alert {
        static let ok = "alert.ok".localizedKey
        static let cancel = "alert.cancel".localizedKey
        static let confirmPermission = "alert.confirm.permission".localizedKey
        static let requestPermission = "alert.request.permission".localizedKey
        static let install = "alert.install".localizedKey
        static let clear = "alert.clear".localizedKey
        static let new = "alert.new".localizedKey
    }

    enum Error {
        static let reload = "error.reload".localizedKey
        static let empty = "error.empty".localizedKey
        static let url = "error.url".localizedString
        static let http = "error.http".localizedString
        static let server = "error.server".localizedString
    }

    enum Toast {
        static let refreshCompleted = "toast.refresh.completed"
        static let refreshFailed = "toast.refresh.failed"
        static let albumCompleted = "toast.album.completed"
        static let albumFailed = "toast.album.failed"
    }
}

extension String {
    var localizedKey: LocalizedStringKey {
        LocalizedStringKey(self)
    }

    var localizedString: String {
        let pref = Preference.shared
        let language = pref.language.locale.languageCode
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj"),
                let bundle = Bundle(path: path) else {
            return ""
        }
        return NSLocalizedString(self, bundle: bundle, comment: "")
    }
}
