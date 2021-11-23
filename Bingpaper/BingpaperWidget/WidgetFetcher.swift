//
//  WidgetFetcher.swift
//  Bingpaper
//
//  Created by zm on 2021/11/3.
//

import WidgetKit

struct WidgetFetcher {

    static func fetchPaper() async -> Timeline<Entry> {

        var entries: [Entry] = []
        var policy: TimelineReloadPolicy
        var entry: Entry

        let date = Date()

        do {
            let paper = try await Fetcher.fetchToday().get()
            entry = try await Entry(paper: paper)
            policy = .after(date.startOfTomorrow)
        } catch  {
            entry = Entry(date)
            policy = .after(min(date.after15min, date.startOfTomorrow))
        }
        entries.append(entry)
        let timeline = Timeline(entries: entries, policy: policy)
        return timeline
    }


    static func fetchDays() -> [PaperDay] {
        let date = Date(), offset = date.startOfMonth.weekday - 1
        return .init(repeating: PaperDay(), count: offset) + date.daysOfMonth.map{PaperDay($0)}
    }
    

}
