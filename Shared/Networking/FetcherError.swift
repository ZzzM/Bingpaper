import Foundation


enum FetcherError: Error, LocalizedError {

    case url, http(Int), server(String)

    var errorDescription: String? {
        switch self {
        case .url: return L10n.Error.url
        case .http(let code):
            return L10n.Error.http != .none ? L10n.Error.http! + "\(code)" : .none
        case .server(let result):
            return L10n.Error.server != .none ? L10n.Error.server! + result : .none
        }
    }
    
}


