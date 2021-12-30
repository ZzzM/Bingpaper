//
//  CircleProgressView.swift
//  Bingpaper
//
//  Created by zm on 2021/11/1.
//

import SwiftUI

struct CircleProgressView: View {

    let completed: CGFloat

    var body: some View {
        Circle()
            .trim(from: 0, to: completed)
            .stroke(.tint, style: StrokeStyle(lineWidth: 5,
                                              lineCap: .round,
                                              lineJoin: .round))
            .frame(width: 30, height: 30)
            .rotationEffect(Angle(degrees: 270))
            .animation(.spring(), value: completed)
    }

}

