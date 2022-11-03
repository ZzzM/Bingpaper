import SwiftUI

class PaperViewModel: StateViewModel {

    @Published
    var isFull = true

    @Published
    var showAlert = false

    @Published
    var showToast = false

    var toast = Toast.deafult

    var isFinished: Bool {
        .loadComplete == state && !isFull
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
        state = .loadError(error.localizedDescription.l10nKey)
    }

    func onSuccess(_ uiImage: UIImage) {
        withAnimation {
            image = uiImage
            state = .loadComplete
        }
    }

    @MainActor
    func save() {
        
        Task {
            
            await PhotoLibrary.requestAuthorizationForAddOnly()

            guard PhotoLibrary.isAuthorizedForAddOnly else {
                showAlert.toggle()
                return
            }

            if  await PhotoLibrary.saveToAblum(image!) {
                showToast = true
                toast = Toast(type: .success, title: L10n.Toast.albumCompleted)
            } else {
                showToast = true
                toast = Toast(type: .failure, title: L10n.Toast.albumFailed)
            }

        }
    }
}
