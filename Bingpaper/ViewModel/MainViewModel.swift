import SwiftUI



class MainViewModel: StateViewModel {

    @Published
    var date = Date()

    @Published
    var paper: Paper?

    @Published
    var showToast = false

    var toast = Toast.deafult

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
                images = try await Fetcher.fetchWeek(mkt: L10n.mkt).get()
                state = isEmpty ? .loadError(L10n.Error.empty):.loadComplete
            } catch {
                state = .loadError(error.localizedDescription.l10nKey)
            }
        }
    }

    @MainActor
    func refresh()  {
        Task {

            defer {
                showToast = true
            }
            do {
                state = .onRefresh
                images = try await Fetcher.fetchWeek(mkt: L10n.mkt).get()
                state = .refreshCompleted
                toast = Toast(type: .success, title: L10n.Toast.refreshCompleted)
            } catch {
                state = .refreshError(error.localizedDescription.l10nKey)
                toast = Toast(type: .failure, title: L10n.Toast.refreshFailed)
            }
        }
    }
}
