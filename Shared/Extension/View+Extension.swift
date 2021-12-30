//
//  View+Extension.swift
//  Bingpaper
//
//  Created by zm on 2021/10/26.
//
import SwiftUI

extension Text {
    func fontWith(_ style: Font.TextStyle, weight: Font.Weight = .light) -> Text {
        font(.system(style, design: .rounded))
            .fontWeight(weight)
    }
}

extension View {

    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }


    func blurStyle() -> some View {
        background(.ultraThinMaterial)
            .cornerRadius(10)
    }

}

@available(iOSApplicationExtension, unavailable)
extension View {

    func showAlert(_ title: String, message: String = "", isPresented: Binding<Bool>, action: @escaping VoidClosure) -> some  View {
        
        alert(title, isPresented: isPresented) {
            Button("是的", role: .cancel,action: action)
            Button("取消", action: {})
        } message: {
            Text(message)
        }
    }

    func open(_ title: String,
              message: String = "",
              urlString: String = UIApplication.openSettingsURLString,
              isPresented: Binding<Bool>) -> some View {

        showAlert(title, message: message, isPresented: isPresented) {
            guard let url = URL(string: urlString) else {
                return
            }
            guard UIApplication.shared.canOpenURL(url) else { return }
            UIApplication.shared.open(url, options:[:], completionHandler: .none)
        }
    }
}

struct CheckboxStyle: ToggleStyle {


    private let offsetX: CGFloat = 8

    func makeBody(configuration: Self.Configuration) -> some View {

        HStack {

            configuration.label

            Spacer()

            Rectangle()
                .foregroundColor(configuration.isOn ? .accentColor : .secondary)
                .frame(width: 35, height: 20)
                .cornerRadius(10)
                .overlay {
                    Circle()
                        .foregroundColor(.white)
                        .offset(x: configuration.isOn ? offsetX : -offsetX)
                        .padding(3)
                }
        }

    }
}
