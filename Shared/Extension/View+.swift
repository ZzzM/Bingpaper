//
//  View+Extension.swift
//  Bingpaper
//
//  Created by zm on 2021/10/26.
//
import SwiftUI

extension View {

    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }

    func barTitle(_ title: LocalizedStringKey) -> some View {
        navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title).font(.title2)
                }
            }
    }

}

@available(iOSApplicationExtension, unavailable)
extension View {

    func showAlert(_ titleKey: LocalizedStringKey, message: String = "", isPresented: Binding<Bool>, action: @escaping VoidClosure) -> some  View {
        
        alert(titleKey, isPresented: isPresented) {
            Button(L10n.Alert.ok, role: .cancel,action: action)
            Button(L10n.Alert.cancel, action: {})
        } message: {
            Text(message)
        }
    }

    func open(_ titleKey: LocalizedStringKey,
              message: String = "",
              urlString: String = UIApplication.openSettingsURLString,
              isPresented: Binding<Bool>) -> some View {

        showAlert(titleKey, message: message, isPresented: isPresented) {
            urlString.open()
        }
    }
}

struct CheckboxStyle: ToggleStyle {
    private let offsetX: CGFloat = 8

    let active: Bool
    
    func makeBody(configuration: Self.Configuration) -> some View {

        HStack {

            configuration.label

            Spacer()

            if active {
                content(configuration: configuration)
                    .animation(.spring(), value: configuration.isOn)
                    .onTapGesture {
                        configuration.isOn.toggle()
                    }
            } else {
                content(configuration: configuration)
            }
         
        }

    }

    private func content(configuration: Self.Configuration) -> some View {
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
