//
//  ListView.swift
//  Bingpaper
//
//  Created by zm on 2021/10/25.
//

import SwiftUI

struct ListItem: View {

    let picture: Picture, onTapGesture: (URL?) -> Void

    var body: some View {

        HStack {

            PhotoView(picture.size200, width: 100) {
                CircleProgressView(completed: $0)
            }

            VStack(alignment: .leading) {
                Text(picture.title)
                    .font(.subheadline)

                Spacer()

                Text(picture.provider)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()

        }
        .background(Color.cellBackground)
        .cornerRadius(10)
        .onTapGesture {
            onTapGesture(picture.url)
        }
    }
}
