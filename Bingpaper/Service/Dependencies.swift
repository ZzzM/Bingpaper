//
//  Dependencies.swift
//  Bingpaper
//
//  Created by zm on 2022/4/7.
//

import Foundation

struct Dependencies {

    private static var url: URL {
        guard let url = Bundle.main.url(forResource: "Dependencies", withExtension: .none) else {
            return Bundle.main.bundleURL
        }
        return url
    }

    static var items: [(String, URL)] {
        guard let contents = FileManager.default.enumerator(at: url,
                                                            includingPropertiesForKeys: .none)
        else { return [] }
        var res: [(String, URL)] = []
        for case let url as URL in contents {
            let title = url.deletingPathExtension().lastPathComponent
            res.append((title, url))
        }
        return res
    }

    static func license(from url: URL) -> [Dependence.Item] {
        let decoder = PropertyListDecoder()
        guard let data = try? Data(contentsOf: url) else { return [] }
        guard let dependence = try? decoder.decode(Dependence.self, from: data) else { return [] }
        return dependence.list.compactMap { try? $0.result.get() }
    }
}


struct Throwable<T: Decodable>: Decodable {
    let result: Result<T, Error>
    init(from decoder: Decoder) throws {
        result = Result(catching: { try T(from: decoder) })
    }
}


struct Dependence: Decodable {
    struct Item: Decodable, Identifiable {
        let id = UUID()
        let footerText: String, license: String
        enum CodingKeys : String, CodingKey {
            case footerText = "FooterText", license = "License"
        }
    }
    enum CodingKeys : String, CodingKey {
        case list = "PreferenceSpecifiers"
    }
    var list: [Throwable<Item>]
}



