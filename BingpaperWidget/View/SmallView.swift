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
                WidgetPhotoView(image: entry.image, isValid: entry.isValid, width: 70, height: 70)
                    .widgetURL(entry.widgetURL)
                Spacer()
                SmallDateView(date: entry.date, height: 70)
            }
            Spacer()
            SmallFootnote(title: entry.title, isValid: entry.isValid)

        }
        .padding()
        .background(Color.cellBackground)

    }

}

struct SmallDateView: View {

    let date: Date, height: CGFloat

    var body: some View {

        let foregroundColor = Preference.shared.palette.color

        VStack {
            Text(L10n.shortWeekday())
                .fontWith(.title3)
                .foregroundColor(foregroundColor)
            Spacer()
            Text(date.day.description).fontWith(.largeTitle)
        }
        .frame(height: height)
    }
}

struct SmallFootnote: View {

    let title: String, isValid: Bool

    var body: some View {

        let foregroundColor = Preference.shared.palette.color

        HStack {
            Text(title)
                .fontWith(.caption2)
                .lineLimit(3)
                .lineSpacing(5)
                .redacted(reason: isValid ? []:.placeholder)
                .foregroundColor(.secondary)
                .padding(.leading)
                .background {
                    HStack {
                        Rectangle()
                            .foregroundColor(foregroundColor)
                            .frame(width: 5)
                            .cornerRadius(2)
                        Spacer()
                    }
                }
            Spacer()
        }

    }
}
