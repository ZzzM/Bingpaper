//
//  PhotoView.swift
//  Bingpaper
//
//  Created by zm on 2021/11/1.
//

import SwiftUI
import Kingfisher

struct PhotoView<T: View>: View {

    let urlString: String
    let width: CGFloat?, height: CGFloat?

    let onFailure: FailureClosure?
    let onSuccess: ((UIImage) -> Void)?
    let onProgress: ((CGFloat) -> T)?
    let onTapGesture: VoidClosure?

    init(_ urlString: String, width: CGFloat? = .none, height: CGFloat? = .none,
         onProgress: ((CGFloat) -> T)? = .none,
         onFailure: FailureClosure? = .none,
         onSuccess: ((UIImage) -> Void)? = .none,
         onTapGesture: VoidClosure? = .none) {
        
        self.urlString = urlString
        self.width = width
        self.height = height
        self.onFailure = onFailure
        self.onSuccess = onSuccess
        self.onProgress = onProgress
        self.onTapGesture = onTapGesture
    }

    @State
    private var isFinished = false

    var body: some View {
        KFImage(URL(string: urlString))
            .resizable()
            .onFailure(onFailure)
            .onSuccess{ result in
                isFinished.toggle()
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
            .onTapGesture {
                if isFinished {
                    onTapGesture?()
                }
            }
    }

}
