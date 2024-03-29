//
//  ToastView.swift
//  Bingpaper
//
//  Created by zm on 2022/1/24.
//

import SwiftUI
import AlertToast

struct ToastViewModifier: ViewModifier {

    @Binding
    var isPresenting: Bool

    let type: ToastType, title: String?

    func body(content: Content) -> some View {
        content.toast(isPresenting: $isPresenting) {
            AlertToast(displayMode: .hud,
                       type: type.systemImage,
                       title: title)
        }
    }

}

enum ToastType {

    case failure, warning, success

    var systemImage: AlertToast.AlertType { .systemImage(imageName, imageColor) }

    private var imageColor: Color {
        switch self {
        case .success: return .green
        case .warning: return .yellow
        case .failure: return .red
        }
    }

    private var imageName: String {
        switch self {
        case .success: return "checkmark.circle.fill"
        case .warning: return "exclamationmark.circle.fill"
        case .failure: return "xmark.circle.fill"
        }
    }

}

struct Toast {
    let type: ToastType, title: String?
    static let `deafult`: Toast = .init(type: .success, title: .none)
}

extension View {
    func toast(isPresenting: Binding<Bool>, toast: Toast) -> some View {
        modifier(ToastViewModifier(isPresenting: isPresenting, type: toast.type, title: toast.title))
    }
}
