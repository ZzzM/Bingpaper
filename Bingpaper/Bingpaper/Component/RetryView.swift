//
//  RetryView.swift
//  Bingpaper
//
//  Created by zm on 2021/10/25.
//

import SwiftUI

struct RetryView: View {

    let message: String,
        action: VoidClosure?

    init(_ message: String, action: VoidClosure? = .none) {
        self.message = message
        self.action = action
    }

    var body: some View {

        VStack {

            Text(message)
                .lineLimit(5)

            if action != nil {
                Button(action: action!) {
                    Text("重新加载")
                        .frame(width: 120, height: 40, alignment: .center)
                        .background(.tint)
                        .cornerRadius(5)
                        .foregroundColor(.white)
                }

            }
        }
        .padding()
        .font(.callout)
        .cornerRadius(10)
        .padding()

    }

}

