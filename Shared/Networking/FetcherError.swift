import Foundation


enum FetcherError: Error, LocalizedError {

    case url, http(Int), server(String)

    var errorDescription: String? {
        switch self {
        case .url: return "URL错误"
        case .http(let code): return "Http 错误：\(code)"
        case .server(let result): return "数据请求错误：" + result
        }
    }
    
}


