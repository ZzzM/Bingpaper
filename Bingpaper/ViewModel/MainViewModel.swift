import SwiftUI


class MainViewModel: StateViewModel {

    @Published
    var date = Date()

    @Published
    var url: URL?

    @Published
    var showToast = false

    var toast = Toast.deafult

    var pictures: [Picture] = []

    var isFinished: Bool {
        state != .onLoading && !isEmpty
    }

    var isBusy: Bool {
        state == .onLoading || state == .onRefresh
    }

    private var isEmpty: Bool {
        pictures.isEmpty
    }

    func present(_ url: URL?) {
        guard url != self.url else { return }
        self.url = url
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
                pictures = try await Fetcher.fetchWeek(mkt: L10n.mkt).get()
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
                pictures = try await Fetcher.fetchWeek(mkt: L10n.mkt).get()
                state = .refreshCompleted
                toast = Toast(type: .success, title: L10n.Toast.refreshCompleted)
            } catch {
                state = .refreshError(error.localizedDescription.l10nKey)
                toast = Toast(type: .failure, title: L10n.Toast.refreshFailed)
            }
        }
    }
}
