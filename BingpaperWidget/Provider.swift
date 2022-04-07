//
//  BingpaperProvider.swift
//  BingpaperWidget
//
//  Created by zm on 2021/11/2.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {

    func placeholder(in context: Context) -> Entry {
        Entry()
    }

    func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
        let entry = Entry()
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {

        Task {
            let timeline = await WidgetFetcher.fetchPaper(mkt: L10n.mkt)
            completion(timeline)
        }

    }
}
