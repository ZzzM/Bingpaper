import SwiftUI

class MainViewModel: StateViewModel {

    @Published
    var date = Date()

    @Published
    var paper: Paper?

    var images: [Paper] = []

    var isFinished: Bool {
        state != .onLoading && !images.isEmpty
    }

    private var isEmpty: Bool {
        images.isEmpty
    }

    func present(_ paper: Paper) {
        guard self.paper?.title != paper.title else { return }
        self.paper = paper
    }

    @MainActor
    func update() {
        
        if date.inToday {
            return
        }

        date = Date()
        
        if isEmpty {
            load()
        } else {
            refresh()
        }

    }

    @MainActor
    func load()  {
        guard isEmpty else { return }
        Task {
            do {
                state = .onLoading
                images = try await Fetcher.fetchWeek().get()
                state = isEmpty ? .loadError("暂无数据"):.loadComplete
            } catch {
                state = .loadError(error.localizedDescription)
            }
        }
    }

    @MainActor
    func refresh()  {
        Task {
            do {
                state = .onRefresh
                images = try await Fetcher.fetchWeek().get()
                state = .refreshCompleted
            } catch {
                state = .refreshError(error.localizedDescription)
            }
        }
    }
}
