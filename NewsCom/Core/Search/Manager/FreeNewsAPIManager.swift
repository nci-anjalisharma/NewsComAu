//
//  FreeNewsAPIManager.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 18/08/26.
//


import Foundation

enum FreeNewsAPIError: Error {
    case invalidURL
    case invalidResponse
    case unauthorized
    case serverError(Int)
    case noData
    case decodingError
}

final class FreeNewsAPIManager {

    static let shared = FreeNewsAPIManager()

    private init() {}

    private let apiKey = "77a1f038f632f732e00dfcb7e43cd79fdff39caead87052fb6eef87d0f2555bc"

    // Fetch News

    func fetchNews(language: String = "en", country: String = "us", completion: @escaping (Result<FreeNewsResponse, Error>) -> Void) {

        var components = URLComponents(string: "https://api.freenewsapi.io/v1/news")

        components?.queryItems = [URLQueryItem(name: "language", value: language), URLQueryItem(name: "country", value: country)]

        guard let url = components?.url else {
            completion(.failure(FreeNewsAPIError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")

        request.setValue("application/json", forHTTPHeaderField: "Accept")

        performRequest(request, completion: completion)
    }
    
    // Fetch Article Details

    func fetchArticleDetails(uuid: String, completion: @escaping (Result<FreeNewsDetailResponse, Error>) -> Void) {

        var components = URLComponents(string: "https://api.freenewsapi.io/v1/details")

        components?.queryItems = [URLQueryItem(name: "uuid", value: uuid)]

        guard let url = components?.url else {
            completion(.failure(FreeNewsAPIError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")

        request.setValue("application/json", forHTTPHeaderField: "Accept")

        performRequest(request, completion: completion)
    }

    // Generic Request

    private func performRequest<T: Decodable>(_ request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {

        URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(FreeNewsAPIError.invalidResponse))
                }
                return
            }

            print("Free News API Status:", httpResponse.statusCode)

            if let data = data {
                print(String(data: data, encoding: .utf8) ?? "Unable to read response")
            }

            switch httpResponse.statusCode {

            case 200...299:
                break

            case 401:
                DispatchQueue.main.async {
                    completion(.failure(FreeNewsAPIError.unauthorized))
                }
                return

            case 400...599:
                DispatchQueue.main.async {
                    completion(.failure(FreeNewsAPIError.serverError(httpResponse.statusCode)))
                }
                return

            default:
                DispatchQueue.main.async {
                    completion(.failure(FreeNewsAPIError.invalidResponse))
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(FreeNewsAPIError.noData))
                }
                return
            }

            do {

                let decoded = try JSONDecoder().decode(T.self, from: data)

                DispatchQueue.main.async {
                    completion(.success(decoded))
                }

            } catch {

                print("Free News API Decoding Error:", error)

                DispatchQueue.main.async {
                    completion(.failure(FreeNewsAPIError.decodingError))
                }
            }

        }.resume()
    }
}
