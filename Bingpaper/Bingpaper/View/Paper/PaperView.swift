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

    let paper: Paper

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

                if viewModel.isFailure {
                    RetryView(viewModel.errorMessage, action: viewModel.onLoading)
                } else {
                    PhotoView(paper.url, width: UIScreen.width,
                              onProgress: { CircleProgressView(completed: $0)},
                              onFailure: viewModel.onFailure,
                              onSuccess: viewModel.onSuccess,
                              onTapGesture: viewModel.fullToggle)
                }

                VStack {

                    if viewModel.showHint {
                        HintView(type: viewModel.type)
                    }

                    Spacer()

                    if viewModel.isFinished {
                        PaperFootnote(paper: paper)
                    }

                }

            }
            .toolbar {

                ToolbarItem(placement: .cancellationAction) {
                    if !viewModel.isFull {
                        PaperButton(imageName: "xmark") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }

                ToolbarItem {
                    if viewModel.isFinished {
                        PaperButton(imageName: "arrow.down") {
                            viewModel.save()
                        }
                        .open("打开相册写入权限？", isPresented: $viewModel.isPresented)
                    }
                }

            }
        }
        .preferredColorScheme(.dark)
        .statusBar(hidden: viewModel.isFull)
        .onAppear(perform: viewModel.fullToggle)
        .onDisappear(perform: viewModel.fullToggle)

    }
}

struct PaperButton: View {
    let imageName: String, action: VoidClosure
    var body: some View {
        Button(action: action) {
            Image(systemName: imageName)
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


