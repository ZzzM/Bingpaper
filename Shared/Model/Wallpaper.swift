import Foundation
import UIKit

struct Wallpaper: Decodable {
    let images: [Picture]
}

struct Picture: Decodable, Identifiable {
    var id: String { hsh }

    let title: String, summary: String, provider: String

    private let urlbase: String, hsh: String, copyright: String

    private enum PictureKey: CodingKey {
        case urlbase, copyright, hsh, title
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PictureKey.self)
        title = try container.decode(String.self, forKey: .title)
        urlbase = try container.decode(String.self, forKey: .urlbase)
        hsh = try container.decode(String.self, forKey: .hsh)
        copyright = try container.decode(String.self, forKey: .copyright)

        let subs = copyright.split(separator: "(")
        summary = subs.first?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? copyright
        provider = subs.last?
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: ")", with: "") ?? copyright

    }

}

extension Picture {

    var size100: String { size(100) }
    var size150: String { size(150) }
    var size200: String { size(200) }
    var size240: String { size(240) }
    var size320: String { size(320) }


    var size240x320: String { size(240, 320) }
    var size360x480: String { size(360, 480) }
    var size480x800: String { size(480, 800) }

    var size640x360: String { size(640, 360) }
    var size800x480: String { size(800, 480) }
    var size1080x1920: String { size(1080, 1920) }

    private func size(_ width: Int, _ height: Int? = .none) -> String {
        Host.bing + urlbase + "_\(width)x\(height ?? width).jpg"
    }
}

extension Picture {
    var url: URL? {
        var components = URLComponents()
        components.scheme = URLScheme.default
        components.path = "wallpaper"
        components.setQueryItems(["id": id,
                                  "title": title,
                                  "summary": summary,
                                  "provider": provider,
                                  "url": size1080x1920])
        return components.url
    }
}
