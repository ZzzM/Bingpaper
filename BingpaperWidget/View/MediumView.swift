//
//  MediumPaperView.swift
//  BingpaperWidget
//
//  Created by zm on 2021/11/4.
//

import SwiftUI

struct MediumView: View {

    let entry: Entry

    var foregroundColor: Color {
        entry.color ?? .red
    }
    
    var body: some View {

        HStack(spacing: .zero) {

            WallpaperView(image: entry.image, url: entry.url)

            CalendarView(date: entry.date,
                         header: header,
                         weekView: weekView,
                         dayView: dayView).padding()
        }
        .frame(maxHeight: .infinity)
        .background(Color.appBackground)

    }

    private func header() -> some View {
        EmptyView()
    }

    private func weekView(date: Date) -> some View {
        Text(L10n.veryShortWeekday(from: date))
            .foregroundColor(date.inWeekend ? .secondary : .primary)
            .font(.caption)
    }


    private func dayView(inSameMonth: Bool, date: Date) -> some View {

        let inToday = date.inToday, inWeekend = date.inWeekend

        let color: Color = inToday ? .white : inWeekend ? .secondary:.primary

        return Text(date.day.description)
            .font(.caption)
            .foregroundColor(inSameMonth ? color: .minor)
            .frame(width: 19, height: 19)
            .background {
                if inToday {
                    Circle()
                        .fill(foregroundColor)
                }
            }

    }

}

struct WallpaperView: View {

    let image: UIImage?, url: URL?

    var body: some View {
        if image != .none, url != .none {
            Link(destination: url!) {
                Image(uiImage: image!).resizable()
            }
        } else {
            Image.photo.font(.largeTitle)
                .frame(maxWidth: .infinity)
        }
    }

}

