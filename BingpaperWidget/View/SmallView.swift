//
//  SmallPaperView.swift
//  BingpaperWidget
//
//  Created by zm on 2021/11/2.
//

import SwiftUI

struct SmallView: View {
    let entry: Entry
    var body: some View {

        VStack {

            HStack {
                WidgetPhotoView(entry: entry, width: 70, height: 70)
                    .widgetURL(entry.widgetURL)
                Spacer()
                SmallDateView(height: 70)
            }
            Spacer()
            SmallFootnote(entry: entry)

        }
        .padding()
        .background(Color.cellBackground)

    }

}

struct SmallDateView: View {

    private let pref = Preference.shared

    let height: CGFloat

    var body: some View {
        VStack {
            Text(Date(), formatter: DateFormatter.weekday)
                .fontWith(.title3)
                .foregroundColor(pref.palette.color)
            Spacer()
            Text(Date().dayName).fontWith(.largeTitle)
        }
        .frame(height: 70)
    }
}

struct SmallFootnote: View {

    private let pref = Preference.shared

    let entry: Entry

    var body: some View {
        HStack {
            Text(entry.title)
                .fontWith(.caption2)
                .lineLimit(3)
                .lineSpacing(5)
                .redacted(reason: entry.isValid ? []:.placeholder)
                .foregroundColor(.secondary)
                .padding(.leading)
                .background {
                    HStack {
                        Rectangle()
                            .foregroundColor(pref.palette.color)
                            .frame(width: 5)
                            .cornerRadius(2)
                        Spacer()
                    }
                }
            Spacer()
        }

    }
}
