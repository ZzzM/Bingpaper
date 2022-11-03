//
//  PhotoView.swift
//  Bingpaper
//
//  Created by zm on 2021/11/1.
//

import SwiftUI
import Kingfisher

struct PhotoView<Content: View>: View {

    let urlString: String
    let width: CGFloat?, height: CGFloat?

    let onFailure: FailureClosure?
    let onSuccess: ((UIImage) -> Void)?
    let onProgress: ((CGFloat) -> Content)?

    init(_ urlString: String, width: CGFloat? = .none, height: CGFloat? = .none,
         onProgress: ((CGFloat) -> Content)? = .none,
         onFailure: FailureClosure? = .none,
         onSuccess: ((UIImage) -> Void)? = .none) {
        
        self.urlString = urlString
        self.width = width
        self.height = height
        self.onFailure = onFailure
        self.onSuccess = onSuccess
        self.onProgress = onProgress
    }

    var body: some View {
        
        KFImage(URL(string: urlString))
            .resizable()
            .onFailure(onFailure)
            .onSuccess{ result in
                onSuccess?(result.image)
            }
            .placeholder{
                onProgress?($0.fractionCompleted)
            }
            .fade(duration: 1)
            .cancelOnDisappear(true)
            .scaledToFill()
            .frame(width: width, height: height)
            .ignoresSafeArea()
    }

}
