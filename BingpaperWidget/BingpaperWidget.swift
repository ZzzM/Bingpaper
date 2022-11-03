//
//  BingpaperWidget.swift
//  BingpaperWidget
//
//  Created by zm on 2021/11/2.
//

import WidgetKit
import SwiftUI

@main
struct BingpaperWidget: Widget {


    var body: some WidgetConfiguration {
        StaticConfiguration(kind: WidgetInfo.kind, provider: Provider()) { entry in
            WidgetContent(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .configurationDisplayName(WidgetInfo.displayName)
        .description(WidgetInfo.description)
    }
}

struct WidgetContent: View {
    @Environment(\.widgetFamily)
    private var family: WidgetFamily

    let entry: Entry
    var body: some View {
        switch family {
        case .systemSmall: SmallView(entry: entry)
        default: MediumView(entry: entry)
        }
    }
}





