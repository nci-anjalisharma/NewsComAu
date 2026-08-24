//
//  AnimeAPIManager.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 17/08/26.
//

import Foundation

final class AnimeAPIManager: NSObject {

    static let shared = AnimeAPIManager()

    private override init() {
        super.init()
    }

    func fetchAnime(id: String, completion: @escaping (Result<Anime, Error>) -> Void) {

        let urlString = "https://cdn.animenewsnetwork.com/encyclopedia/api.xml?anime=\(id)"

        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in

            if let error {
                completion(.failure(error))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data else {
                completion(.failure(NetworkError.noData))
                return
            }

            let parser = AnimeXMLParser()

            parser.parse(data: data) { result in
                completion(result)
            }
            
        }.resume()
    }
    
    func fetchAnimeList(ids: [String], completion: @escaping (Result<[Anime], Error>) -> Void) {

        let group = DispatchGroup()

        var animeList: [Anime] = []
        var errors: [Error] = []

        let lock = NSLock()

        for id in ids {

            group.enter()

            fetchAnime(id: id) { result in

                lock.lock()
                defer {
                    lock.unlock()
                    group.leave()
                }

                switch result {

                case .success(let anime):
                    animeList.append(anime)

                case .failure(let error):
                    errors.append(error)
                }
            }
        }

        group.notify(queue: .main) {

            if animeList.isEmpty {

                completion(.failure(errors.first ?? NetworkError.noData))

            } else {

                completion(.success(animeList))
            }
        }
    }
}
