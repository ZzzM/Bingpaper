//
//  PictureView.swift
//  Bingpaper
//
//  Created by zm on 2022/6/22.
//

import SwiftUI

struct PictureView: View {

    let title: String, urlString: String, url: URL?, width: CGFloat, height: CGFloat, onTapGesture: (URL?) -> Void

    @State
    private var color: Color?

    private var textBackground: LinearGradient? {
        guard color != .none else { return .none }
        return LinearGradient(colors: [color!, .clear],
                              startPoint: .bottom,
                              endPoint: .top)
    }

    var body: some View {
        PhotoView(urlString, width: width, height: height) {
            CircleProgressView(completed: $0)
        } onSuccess: {
            guard let uiColor = $0.averageColor else { return }
            color = Color(uiColor: uiColor)
        }
        .overlay(alignment: .bottom) {
            if textBackground != nil {
                Text(title)
                    .font(.callout)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(textBackground)
                    .transition(.opacity.animation(.easeInOut))
            }
        }
        .background(Color.cellBackground)
        .cornerRadius(10)
        .onTapGesture {
            onTapGesture(url)
        }
    }

    static func placeholder(width: CGFloat? = .none,
                                  height: CGFloat? = .none) -> some View {
        Image.photo
            .font(.largeTitle)
            .foregroundColor(.minor)
            .frame(width: width, height: height)
            .background(Color.cellBackground.cornerRadius(10))
    }
}

extension PictureView {

    static let w2 = (UIScreen.width - 40)/2, h2 =  w2*5/3

    static func gridItem(picture: Picture, onTapGesture: @escaping (URL?) -> Void) -> some View {
        PictureView(title: picture.title,
                    urlString: picture.size480x800,
                    url: picture.url,
                    width: w2,
                    height: h2,
                    onTapGesture: onTapGesture)
    }
    static var gridPlaceholder: some View {
        placeholder(width: w2, height: h2)
    }

}

extension PictureView {

    static let w1 = UIScreen.width - 30, h1 =  w1*3/5

    static func todayItem(picture: Picture, onTapGesture: @escaping (URL?) -> Void) -> some View {
        PictureView(title: picture.title,
                    urlString: picture.size800x480,
                    url: picture.url,
                    width: w1,
                    height: h1,
                    onTapGesture: onTapGesture)
    }
    static var todayPlaceholder: some View {
        placeholder(width: w1, height: h1)
    }

}
