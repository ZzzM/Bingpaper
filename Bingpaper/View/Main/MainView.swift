
import SwiftUI

struct MainView: View {

    @StateObject
    private  var viewModel = MainViewModel()

    @EnvironmentObject
    private var pref: Preference

    var body: some View {

        NavigationView {
            content
                .navigationBarTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    toolbarContent
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
        .onChange(of: pref.language) { _ in
            viewModel.refresh()
        }
        .toast(isPresenting: $viewModel.showToast, toast: viewModel.toast)

        
    }

}

extension MainView {

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
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

    private var content: some View {
        ZStack {
            if viewModel.isFinished {
                scrollView
            }
            if case .onLoading = viewModel.state {
                scrollViewPlaceholder
            } else if case  .loadError(let message) = viewModel.state {
                RetryView(message) { viewModel.load() }
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

