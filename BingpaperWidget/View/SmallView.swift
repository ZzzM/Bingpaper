//
//  SmallPaperView.swift
//  BingpaperWidget
//
//  Created by zm on 2021/11/2.
//

import SwiftUI

struct SmallView: View {
    let entry: Entry

    var textBackground: LinearGradient? {
        guard let color = entry.color else { return .none }
        return LinearGradient(colors: [color, .clear],
                              startPoint: .bottom,
                              endPoint: .top)
    }

    var body: some View {

        if let image = entry.image, let url = entry.url {

            Image(uiImage: image).resizable()
                .widgetURL(url)
                .overlay(alignment: .bottomLeading) {

                    Text(entry.summary)
                        .font(.caption)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(textBackground)
                }

        } else {
            Image.photo.font(.largeTitle)
        }

    }

}

