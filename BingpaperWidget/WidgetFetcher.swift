//
//  WidgetFetcher.swift
//  Bingpaper
//
//  Created by zm on 2021/11/3.
//

import WidgetKit
import SwiftUI

typealias Entry = PictureEntry

struct PictureEntry: TimelineEntry {

    let date: Date, image: UIImage?, title: String, summary: String, url: URL?

    init(date: Date = Date(), image: UIImage? = .none, title: String? = .none, summary: String? = .none, url: URL? = .none) {
        self.date = date
        self.image = image
        self.title = title ?? ""
        self.summary = summary ?? ""
        self.url = url
    }

    var color: Color? {
        guard let uiColor =  image?.averageColor else { return .none }
        return Color(uiColor: uiColor)
    }
    
}

struct WidgetFetcher {

    
    static func fetchToday(mkt: String) async -> Timeline<Entry> {

        var entries: [Entry] = []
        var policy: TimelineReloadPolicy
        var entry: Entry

        let date = Date()

        do {
            let picture = try await Fetcher.fetchToday(mkt: mkt).get()
            let data = try await Fetcher.download(picture.size320).get()
            let image = UIImage(data: data)
            entry = Entry(date: date,
                          image: image,
                          title: picture.title,
                          summary: picture.summary,
                          url: picture.url)
            policy = .after(date.startOfTomorrow)
        } catch  {
            entry = Entry(date: date)
            policy = .after(min(date.after15min, date.startOfTomorrow))
        }
        entries.append(entry)
        let timeline = Timeline(entries: entries, policy: policy)
        return timeline
    }

}
