//
//  WidgetPhotoView.swift
//  BingpaperWidget
//
//  Created by zm on 2021/11/4.
//

import SwiftUI

struct WidgetPhotoView: View {

    let image: UIImage?, isValid: Bool, width: CGFloat, height: CGFloat

    var body: some View {
        ZStack {
            if isValid, image != nil {
                Image(uiImage: image!)
                    .resizable()
                    .frame(width: width, height: height)
            } else {
                PhotoPlaceholder(size: 30, width: width, height: height)
            }
        }
        .cornerRadius(5)

    }
}
