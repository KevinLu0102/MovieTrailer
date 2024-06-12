//
//  NetworkService.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/11.
//

import Foundation

protocol NetworkProtocol {
    func fetch<T: Decodable>(with request: URLRequest?, completion: @escaping (Result<T, NetworkError>) -> Void)
}

class NetworkService: NetworkProtocol {

    static let shared = NetworkService()
    
    private init() {}
    
    func fetch<T>(with request: URLRequest?, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        
        guard let request = request else {
            return completion(.failure(.requestNilError))
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.requestError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.dataError))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.unknownError(error)))
            }
        }.resume()
    }
}
