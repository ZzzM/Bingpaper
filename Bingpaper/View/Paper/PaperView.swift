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

    @Environment(\.presentationMode)
    private var presentationMode

    private let paper: Paper

    init(_ paper: Paper) {
        self.paper = paper
        let bar = UINavigationBar.appearance()

        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        bar.standardAppearance = appearance
        bar.scrollEdgeAppearance = appearance
    }

    var body: some View {

        NavigationView {
            ZStack {
                content
                footnote
            }
            .toolbar {
                toolbarContent
            }
        }
        .preferredColorScheme(.dark)
        .statusBar(hidden: viewModel.isFull)
        .onAppear(perform: viewModel.fullToggle)
        .onDisappear(perform: viewModel.fullToggle)
        .toast(isPresenting: $viewModel.showToast, toast: viewModel.toast)
    }


    @ViewBuilder
    private var content: some View {
        if case .loadError(let message) = viewModel.state {
            RetryView(message, action: viewModel.onLoading)
        } else {
            PhotoView(paper.url, width: UIScreen.width,
                      onProgress: { CircleProgressView(completed: $0)},
                      onFailure: viewModel.onFailure,
                      onSuccess: viewModel.onSuccess,
                      onTapGesture: viewModel.fullToggle)
        }
    }


    @ViewBuilder
    private var footnote: some View {
        VStack {
            Spacer()
            if viewModel.isFinished {
                PaperFootnote(paper: paper)
            }
        }
    }


    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {

        ToolbarItem(placement: .cancellationAction) {
            if !viewModel.isFull {
                PaperButton(image: .close) {
                    if viewModel.showToast { return }
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }

        ToolbarItem {
            if viewModel.isFinished {
                PaperButton(image: .download) {
                    viewModel.save()
                }
                .open(L10n.Alert.requestPermission, isPresented: $viewModel.showAlert)
            }
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


struct PaperFootnote: View {
    let paper: Paper

    var body: some View {
        Group {
            Text(paper.title).font(.footnote) +
            Text("\n") +
            Text(paper.ps).font(.caption)
        }
        .padding(5)
        .multilineTextAlignment(.center)
        .background(.ultraThinMaterial)
        .cornerRadius(5)
        .transition(.move(edge: .bottom))
        .padding(.horizontal)
    }
}


