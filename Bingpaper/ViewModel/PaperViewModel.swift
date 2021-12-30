import SwiftUI

class PaperViewModel: StateViewModel {

    @Published
    var isFull = true

    @Published
    var isPresented = false

    @Published
    var type: HintType = .none

    var isFailure: Bool {
        if  case .loadError = state {
            return true
        }
        return false
    }

    var showHint: Bool {
        switch type {
        case .none: return false
        default: return true
        }
    }

    var isFinished: Bool {
        .loadComplete == state && !isFull
    }

    var errorMessage: String {
        if case let .loadError(message) = state {
            return message
        }
        return ""
    }


    private var image: UIImage?

    func fullToggle() {
        withAnimation {
            isFull.toggle()
        }
    }

    func onLoading() {
        state = .onLoading
    }

    func onFailure(_ error: Error) {
        state = .loadError(error.localizedDescription)
    }

    func onSuccess(_ cpImage: UIImage) {
        withAnimation {
            image = cpImage
            state = .loadComplete
        }
    }

    @MainActor
    func save() {
        
        Task {

            await PhotoLibrary.requestAuthorizationForAddOnly()

            guard PhotoLibrary.isAuthorizedForAddOnly else {
                isPresented.toggle()
                return
            }

            type = .none
            if  await PhotoLibrary.saveToAblum(image!) {
                type = .success("已保存到相册")
            } else {
                type = .failure("保存失败")
            }

        }
    }
}
