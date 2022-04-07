//
//  MediumPaperView.swift
//  BingpaperWidget
//
//  Created by zm on 2021/11/4.
//

import SwiftUI

struct MediumView: View {

    let entry: Entry

    private let foregroundColor = Preference.shared.palette.color

    var body: some View {

        HStack {

            GeometryReader { p in
                WidgetPhotoView(image: entry.image, isValid: entry.isValid, width: p.size.height, height: p.size.height)
            }
            .widgetURL(entry.widgetURL)

            Spacer()

            CalendarView(header: header, weekView: weekView, dayView: dayView)

        }
        .padding()
        .background(Color.cellBackground)

    }

    private func header() -> some View {
        Text(L10n.month())
            .foregroundColor(foregroundColor)
            .fontWith(.caption, weight: .regular)
            .padding(.bottom, 3)
    }

    private func weekView(date: Date) -> some View {
        Text(L10n.veryShortWeekday(from: date))
            .foregroundColor(date.inWeekend ? .secondary : .primary)
            .fontWith(.caption2)
    }


    private func dayView(inSameMonth: Bool, date: Date) -> some View {
        ZStack {
            if date.inToday {
                Rectangle()
                    .foregroundColor(foregroundColor)
                    .frame(minWidth: 16, maxWidth: 18, minHeight: 16, maxHeight: 18)
                    .cornerRadius(3)
            }

            Text(date.day.description)
                .fontWith(.caption2)
                .foregroundColor(date.inToday ? .white:
                                    date.inWeekend ? .secondary:.primary)
        }
        .opacity(inSameMonth ? 1:0.2)
    }

}
