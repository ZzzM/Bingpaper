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

    private let locale = Preference.shared.language.locale
    private var colorScheme: ColorScheme? { Preference.shared.theme.colorScheme }

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: WidgetInfo.kind, provider: Provider()) { entry in
            WidgetContent(entry: entry)
                .environment(\.locale, locale)
                .modifier(ColorSchemeModifier(colorScheme: colorScheme))
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

struct ColorSchemeModifier: ViewModifier {
    let colorScheme: ColorScheme?
    func body(content: Content) -> some View {
        if let _colorScheme = colorScheme {
            content.environment(\.colorScheme, _colorScheme)
        } else {
            content
        }
    }
}



