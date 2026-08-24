//
//  APIManager.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 26/05/26.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case noData
}

public class APIManager {
    
    static let shared = APIManager()
    
    private init(){}
    func fetchNewsData<T: Codable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
            
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
            
        URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                print("ERROR:")
                print(error)
                completion(.failure(error))
                return
            }

            if let response = response as? HTTPURLResponse {
                print("STATUS CODE:", response.statusCode)
            }

            if let data = data {
                print("RAW RESPONSE:")
                print(String(data: data, encoding: .utf8) ?? "Unable to convert")
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                print("DECODING ERROR:")
                print(error)
                completion(.failure(NetworkError.decodingError))
            }

        }.resume()
        
        }
}


