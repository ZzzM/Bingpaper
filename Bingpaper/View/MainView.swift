
import SwiftUI

struct MainView: View {

    @StateObject
    private  var viewModel = MainViewModel()

    @EnvironmentObject
    private var pref: Preference

    var body: some View {

        NavigationView {
            content
                .background(Color.appBackground)
                .navigationBarTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    toolbarContent
                }

        }
        .fullScreenCover(item: $viewModel.url) {
            PaperView($0)
        }
        .onReceive(NotificationCenter.Publisher.sceneWillPresent) {
            guard let url = $0.object as? URL else { return }
            viewModel.present(url)
        }
        .onReceive(NotificationCenter.Publisher.sceneWillEnterForeground) { _ in
            viewModel.update()
        }
        .onAppear {
            viewModel.load()
        }
        .toast(isPresenting: $viewModel.showToast, toast: viewModel.toast)

    }


}

extension MainView {

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Text("\(viewModel.date.month) / \(viewModel.date.day)").font(.title2)
        }
        ToolbarItem(placement: .primaryAction) {

            NavigationLink(destination: SettingsView.init) {
                Image.settings
            }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                pref.isGrid.toggle()
            } label: {
                pref.isGrid ?  Image.list : Image.grid
            }
        }


    }

    @ViewBuilder
    private var content: some View {

        if viewModel.isFinished {
            MainScrollView(pictures: viewModel.pictures,
                           isGrid: pref.isGrid,
                           columns: pref.columns,
                           onTapGesture: viewModel.present)
        } else if viewModel.isBusy {
            MainPlaceholder(isGrid: pref.isGrid)
        } else if case .loadError = viewModel.state {
            Button {
                viewModel.load()
            } label: {
                Image.refresh.font(.largeTitle)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }

        // Solution to NavigationLink unexpected pop back to previous screen
        NavigationLink {} label: {}
    }

}

struct MainScrollView: View {

    let pictures: [Picture],  isGrid: Bool, columns: [GridItem],  onTapGesture: (URL?) -> Void

    var body: some View {
        ScrollView {
            Section {
                LazyVGrid(columns: columns) {
                    ForEach(pictures[1...], id: \.id) {
                        if isGrid {
                            PictureView.gridItem(picture: $0, onTapGesture: onTapGesture)
                        } else {
                            ListItem(picture: $0, onTapGesture: onTapGesture)
                        }
                    }.transition(.move(edge: .bottom).combined(with: .opacity))
                }.animation(.spring(), value: isGrid)
            } header: {
                PictureView.todayItem(picture: pictures[0], onTapGesture: onTapGesture)
            }
            .padding()

        }
    }
}


struct MainPlaceholder: View {

    let isGrid: Bool

    private var columns: [GridItem] {
        Array(repeating: GridItem(), count: isGrid ? 2:1)
    }

    var body: some View {
        ScrollView {
            Section {
                LazyVGrid(columns: columns) {
                    ForEach(0 ..< 6, id: \.self) { _ in
                        if isGrid {
                            PictureView.gridPlaceholder
                        } else {
                            listPlaceholder
                        }
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }.animation(.spring(), value: isGrid)

                
            } header: {
                PictureView.todayPlaceholder
            }
            .padding()



        }
        .disabled(true)

    }




    private var listPlaceholder: some View {
        HStack {
            PictureView.placeholder(width: 100)


            VStack(alignment: .leading) {
                Text("This is a placeholder!!!!!!!!!!!!!")
                    .font(.subheadline)


                Spacer()
                Text("This is a placeholder")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
            }
            .redacted(reason: .placeholder)
            .padding()
        }
        .background(Color.cellBackground.cornerRadius(10))
        .frame(height: 100)
    }

}
