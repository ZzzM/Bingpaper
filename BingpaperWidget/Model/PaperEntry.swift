//
//  PaperEntry.swift
//  BingpaperWidget
//
//  Created by zm on 2021/11/2.
//

import WidgetKit
import UIKit

typealias Entry = PaperEntry

struct PaperEntry: TimelineEntry {

    let date: Date, image: UIImage?
    private let paper: Paper?

    var isValid: Bool {
        image != nil
    }

    var title: String {
        isValid ? paper!.title : "xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    }

    var widgetURL: URL? {
        paper?.widgetURL
    }

    init(_ date: Date = Date()) {
        self.date = date
        self.paper = .none
        self.image = .none
    }

    init(paper: Paper) async throws {
        self.date = Date()
        self.paper = paper
        do {
            let data = try await Fetcher.download(paper.thumbnailUrl).get()
            self.image = UIImage(data: data)
        } catch {
            self.image = .none
        }
    }
}
