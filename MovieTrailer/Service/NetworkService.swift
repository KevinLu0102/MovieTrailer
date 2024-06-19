//
//  NetworkService.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/11.
//

import Foundation
import Combine

protocol NetworkProtocol {
    func fetch<T: Decodable>(with request: URLRequest?) -> AnyPublisher<T, NetworkError>
}

class NetworkService: NetworkProtocol {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func fetch<T>(with request: URLRequest?) -> AnyPublisher<T, NetworkError> where T : Decodable {
        
        guard let request = request else {
            return Fail(error: NetworkError.requestNilError)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.responseHttpError
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.responseError(httpResponse.statusCode)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> NetworkError in
                if let networkError = error as? NetworkError {
                    return networkError
                } else if let decodingError = error as? DecodingError {
                    return NetworkError.decodingError(decodingError)
                } else {
                    return NetworkError.unknownError(error)
                }
            }
            .eraseToAnyPublisher()
    }
}
