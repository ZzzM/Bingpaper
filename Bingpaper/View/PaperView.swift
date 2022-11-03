//
//  PaperView.swift
//  Bingpaper
//
//  Created by zm on 2021/10/25.
//

import SwiftUI

struct PaperView: View {

    @StateObject
    private var viewModel = PaperViewModel()

    @Environment(\.dismiss)
    private var dismiss

    private let title: String, summary: String, provider: String, urlString: String

    init(_ url: URL) {
        let bar = UINavigationBar.appearance()

        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        bar.standardAppearance = appearance
        bar.scrollEdgeAppearance = appearance

        title = url["title"] ?? ""
        summary = url["summary"] ?? ""
        provider = url["provider"] ?? ""
        urlString = url["url"] ?? ""
    }

    var body: some View {

        content
            .overlay(alignment: .top, content: {
                HStack {
                    if !viewModel.isFull {
                        PaperButton(image: .close) {
                            if viewModel.showToast { return }
                            dismiss()
                        }
                        .transition(.move(edge: .leading).combined(with: .opacity))
                    }

                    Spacer()
                    if viewModel.isFinished {
                        PaperButton(image: .download) {
                            viewModel.save()
                        }
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                     
                    }
                }
                .padding(.horizontal)

            })
            .preferredColorScheme(.dark)
            .statusBar(hidden: viewModel.isFull)
            .onAppear(perform: viewModel.fullToggle)
            .onDisappear(perform: viewModel.fullToggle)
            .toast(isPresenting: $viewModel.showToast, toast: viewModel.toast)
    }


    @ViewBuilder
    private var content: some View {
        if case .loadError = viewModel.state {
            Button {
                viewModel.onLoading()
            } label: {
                Image.refresh.font(.largeTitle)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            PhotoView(urlString, width: UIScreen.width,
                      onProgress: { CircleProgressView(completed: $0)},
                      onFailure: viewModel.onFailure,
                      onSuccess: viewModel.onSuccess)
            .overlay(alignment: .bottom) {
                if viewModel.isFinished {
                    FootnoteView(title: title, summary: summary, provider: provider)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .onTapGesture(perform: viewModel.fullToggle)
        }
    }


}

struct PaperButton: View {
    let image: Image, action: VoidClosure
    var body: some View {
        Button(action: action) {
            image
                .foregroundColor(.white)
                .imageScale(.small)
                .frame(width: 30, height: 30)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
        }
    }
}


struct FootnoteView: View {
    let title: String, summary: String, provider: String

    var body: some View {

        VStack(spacing: 10) {
            Text(title).font(.headline)
            Text(summary).font(.subheadline)
            Text(provider).font(.caption)
        }
        .multilineTextAlignment(.center)
        .padding()
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)

    }
}


