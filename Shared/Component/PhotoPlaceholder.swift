//
//  PhotoPlaceholder.swift
//  Bingpaper
//
//  Created by zm on 2021/10/25.
//

import SwiftUI

struct PhotoPlaceholder: View {

    let name: String, size: CGFloat, width: CGFloat?, height: CGFloat?


    init(_ name: String = "photo", size: CGFloat, width: CGFloat? = .none, height: CGFloat? = .none) {
        self.name = name
        self.size = size
        self.width = width
        self.height = height
    }

    var body: some View {

        Rectangle()
            .fill()
            .frame(width: width, height: height)
            .overlay {
                Image(systemName: name)
                    .font(.system(size: size))
                    .foregroundColor(.minor)
            }
    }
}

