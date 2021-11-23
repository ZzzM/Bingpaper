//
//  Networking.swift
//  Bingpaper
//
//  Created by zm on 2021/10/25.
//

import UIKit

struct Fetcher {

    private static let shared = Fetcher()


    static func fetchWeek(size: String = "7") async -> Result<[Paper], Error> {
        do {
            let reulst: Result<Papers, Error> = await shared.request(.fetchPapers(size))
            let images = try reulst.get().images
            return .success(images)
        } catch {
            return .failure(error)
        }
    }

    static func fetchToday() async -> Result<Paper, Error> {
        do {
            let images = try await fetchWeek(size: "1").get()
            if images.isEmpty {
                return .failure(FetcherError.url)
            }
            let paper = images[0]
            return .success(paper)
        } catch  {
            return .failure(error)
        }
    }

    static func checkForUpdate() async -> Version {
        do {
            let reulst: Result<Version, Error> = await shared.request(.checkForUpdate)
            return try reulst.get()
        } catch {
            return .init()
        }
    }

    static func download(_ urlStrig: String) async -> Result<Data, Error> {
        await shared.request(from: URL(string: urlStrig))
    }

}

extension Fetcher {

    private func request<T: Decodable>(_ endpoint: Endpoint) async -> Result<T, Error> {
        do {
            let result = await request(from: endpoint.url)
            let data = try result.get()
            if endpoint.logged {
                let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers])
                print(json)
            }
            let model = try JSONDecoder().decode(T.self, from: data)
            return .success(model)
        } catch  {
            return .failure(error)
        }
    }

    private func request(from url: URL?) async -> Result<Data, Error> {

        guard let _url = url else {
            return .failure(FetcherError.url)
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: _url)
            guard let response = response as? HTTPURLResponse else {
                return .failure(FetcherError.url)
            }
            guard  response.statusCode == 200 else {
                return .failure(FetcherError.http(response.statusCode))
            }
            return .success(data)
        } catch {
            return .failure(error)
        }
    }

}

