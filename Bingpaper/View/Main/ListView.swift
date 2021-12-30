//
//  ListView.swift
//  Bingpaper
//
//  Created by zm on 2021/10/25.
//

import SwiftUI

struct ListView: View {

    let images: [Paper], onTapGesture: (Paper) -> Void

    var body: some View {
        ForEach(images[1...].indices, id: \.self) { index in
            
            let paper =  images[index]

            ListItem(paper: paper)
                .onTapGesture {
                    onTapGesture(paper)
                }

        }
    }
}


struct ListViewPlaceholder: View {

    var body: some View {
        ForEach(0 ..< 6) { i in
            ListItem(paper: .none)
        }
    }

}

struct ListItem: View {

    let paper: Paper?

    private var thumbnailUrl: String {
        paper != nil ? paper!.thumbnailUrl : ""
    }

    private var title: String {
        paper != nil ? paper!.title : "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    }

    private var ps: String {
        paper != nil ? paper!.ps : "xxxxxxxxxxxx"
    }

    private var reason: RedactionReasons {
        paper != nil ? [] : .placeholder
    }

    var body: some View {
        HStack {

            if thumbnailUrl.isEmpty {
                PhotoPlaceholder(size: 40, width: 150, height: 150)
            } else {
                PhotoView(thumbnailUrl, width: 150, height: 150) { _ in
                    PhotoPlaceholder(size: 40, width: 150, height: 150)
                }
                .disabled(true)
            }

            Spacer()

            VStack {
                Text(title)
                    .font(.subheadline)
                    .lineLimit(2)
                Spacer()
                Text(ps)
                    .font(.caption2)
            }
            .padding()
            .redacted(reason: reason)

        }
        .background(Color.cellBackground)
        .cornerRadius(10)
    }
}
