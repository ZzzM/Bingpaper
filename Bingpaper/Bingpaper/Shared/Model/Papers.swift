import Foundation
import UIKit
import MapKit

struct Papers: Decodable {
    let images: [Paper]
}

struct Paper: Decodable, Identifiable {

    let id = UUID()

    let url: String, thumbnailUrl: String, title: String
    var ps = ""

    private enum PaperKey: CodingKey {
        case urlbase, copyright
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PaperKey.self)
        let urlbase = try container.decode(String.self, forKey: .urlbase)
        thumbnailUrl = Host.bing + urlbase + "_200x200.jpg"
        url = Host.bing + urlbase + "_1080x1920.jpg"
        

        let temp = try container.decode(String.self, forKey: .copyright)
            .split(separator: "(")
        title = temp[0].trimmingCharacters(in: .whitespacesAndNewlines)
        if temp.count > 1 {
            ps = temp[1].trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: ")", with: "")
        }

    }


}

extension Paper {

    init?(widgetURL: URL) {
        guard let components = URLComponents(string: widgetURL.absoluteString) else {
            return nil
        }
        title = components.parameters["title"] ?? ""
        url = components.parameters["url"] ?? ""
        ps = components.parameters["ps"] ?? ""
        thumbnailUrl = ""
    }

    var widgetURL: URL? {
        var components = URLComponents()
        components.scheme = URLScheme.default
        components.path = "paper"
        components.setQueryItems(["title": title, "url": url, "ps": ps])
        return components.url
    }
}
