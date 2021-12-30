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

    @StateObject
    private var pref = WidgetPreference()


    var body: some WidgetConfiguration {
        StaticConfiguration(kind: WidgetInfo.kind, provider: Provider()) { entry in
            WidgetContent(entry: entry)
                .environmentObject(pref)
                
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

class WidgetPreference: ObservableObject {
    @AppStorage(AppStorageKey.palette, store: UserDefaults.default)
    private var palette: Palette = .default

    var tint: Color {
        palette.color
    }
}
