//
//  TodayView.swift
//  Bingpaper
//
//  Created by zm on 2021/10/25.
//

import SwiftUI

struct TodayView: View {

    let paper: Paper, onTapGesture: (Paper) -> Void

    var body: some View {
        PhotoView(paper.url, height: UIScreen.height/3) {
            CircleProgressView(completed: $0)
        } onTapGesture: {
            onTapGesture(paper)
        }
        .background(Color.cellBackground)
        .cornerRadius(10)
    }

}

struct TodayViewPlaceholder: View {
    var body: some View {
        PhotoPlaceholder(size: 80, height: UIScreen.height/3)
            .background(Color.cellBackground)
            .cornerRadius(10)
    }
}
