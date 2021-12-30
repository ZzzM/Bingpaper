//
//  HintView.swift
//  Bingpaper
//
//  Created by zm on 2021/10/25.
//

import SwiftUI

enum HintType {

    case failure(String),
         warning(String),
         success(String),
         none

    var background: Color {
        switch self {
        case .failure: return .red
        case .warning: return .yellow
        case .success: return .green
        case .none: return .clear
        }
    }

    var message: String {
        switch self {
        case .failure(let message): return message
        case .warning(let message): return message
        case .success(let message): return message
        case .none: return ""
        }
    }
}


struct HintView: View {

    private enum HintState {
        case idle, appear, disappear
    }

    @State
    private var state: HintState = .idle

    var type: HintType

    var body: some View {

        switch state {
        case .idle:
            Spacer(minLength: 30)
                .onAppear {
                    withAnimation {
                        state = .appear
                    }
                }
        case .appear:
            HStack {
                Spacer()
                Text(type.message)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .font(.callout)
                    .padding(5)
                Spacer()
            }
            .background(type.background)
            .cornerRadius(5)
            .padding(.horizontal)
            .transition(.move(edge: .top))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        state = .disappear
                    }
                }
            }
        case .disappear:
            EmptyView()
        }
        
    }

}


