
import SwiftUI

struct MainView: View {

    @StateObject
    private  var viewModel = MainViewModel()

    var body: some View {

        NavigationView {
            content
                .navigationBarTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Text("\(viewModel.date.month) ").fontWith(.largeTitle) +
                        Text("/ ").fontWith(.title) +
                        Text("\(viewModel.date.day)").fontWith(.title3)

                    }
                    ToolbarItem(placement: .primaryAction) {
                        NavigationLink(destination: SettingsView.init) {
                            Image.settings
                        }
                    }
                }
        }
        .fullScreenCover(item: $viewModel.paper) {
            PaperView($0)
        }
        .onReceive(NotificationCenter.Publisher.sceneWillPresent) {
            guard let paper = $0.object as? Paper else { return }
            viewModel.present(paper)
        }
        .onReceive(NotificationCenter.Publisher.sceneWillEnterForeground) { _ in
            viewModel.update()
        }
        .onAppear {
            viewModel.load()
        }
        
    }

}

extension MainView {
    private var content: some View {

        ZStack {

            if viewModel.isFinished {
                scrollView
            }

            if case .onLoading = viewModel.state {
                scrollViewPlaceholder
            } else if case let .loadError(message) = viewModel.state {
                RetryView(message) { viewModel.load() }
            } else if case let .refreshError(message) = viewModel.state {
                hintView(.failure(message))
            } else if case .refreshCompleted = viewModel.state {
                hintView(.success("更新完成"))
            }

        }
    }

    private var scrollViewPlaceholder: some View {
        List {
            Group {
                TodayViewPlaceholder()
                ListViewPlaceholder()
            }
            .listRowBackground(Color.appBackground)
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .background(Color.appBackground)
    }

    private var scrollView: some View {

        List {
            Group {
                TodayView(paper: viewModel.images[0], onTapGesture: viewModel.present)
                ListView(images: viewModel.images, onTapGesture: viewModel.present)
            }
            .listRowBackground(Color.appBackground)
            .listRowSeparator(.hidden)

        }
        .listStyle(.plain)
        .background(Color.appBackground)
        .refreshable {
            viewModel.refresh()
        }


    }
    
}


extension MainView {

    private func hintView(_ type: HintType) -> some View {
        VStack {
            HintView(type: type)
            Spacer()
        }
    }

}

