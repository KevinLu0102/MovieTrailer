//
//  RequestFactory.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/18.
//

import Foundation

protocol MovieRequestProtocol {
    func createUpcoming(page: Int) -> URLRequest?
    func createDetail(movieId: Int) -> URLRequest?
    func createVideo(movieId: Int) -> URLRequest?
    func createImages(movieId: Int) -> URLRequest?
    func createSimilar(movieId: Int) -> URLRequest?
}

class MovieRequestFactory: MovieRequestProtocol {
    private let baseURL: String
    private let apiKey: String
    private let language: String
    
    init(baseURL: String = "https://api.themoviedb.org/3/movie",
         apiKey: String = "aefd8f383ce4794e8c98eb8132c161ca",
         language: String = "en") {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.language = language
    }
    
    internal func produceRequest(url: String, method: HTTPMethod, key: String, queryItems: [URLQueryItem]?) -> URLRequest? {
        guard let url = URL(string: url) else {
            return nil
        }
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        components.queryItems = [URLQueryItem(name: "api_key", value: apiKey),
                                 URLQueryItem(name: "language", value: language)]
        
        if let queryItems = queryItems {
            components.queryItems?.append(contentsOf: queryItems)
        }
        
        guard let url = components.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "accept")
        
        return request
    }
    
    func createUpcoming(page: Int) -> URLRequest? {
        let queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        let url = "\(baseURL)/upcoming"
        return produceRequest(url: url, method: .get, key: apiKey, queryItems: queryItems)
    }
    
    func createDetail(movieId: Int) -> URLRequest? {
        let url = "\(baseURL)/\(movieId)"
        return produceRequest(url: url, method: .get, key: apiKey, queryItems: nil)
    }
    
    func createVideo(movieId: Int) -> URLRequest? {
        let url = "\(baseURL)/\(movieId)/videos"
        return produceRequest(url: url, method: .get, key: apiKey, queryItems: nil)
    }
    
    func createImages(movieId: Int) -> URLRequest? {
        let url = "\(baseURL)/\(movieId)/images"
        return produceRequest(url: url, method: .get, key: apiKey, queryItems: nil)
    }
    
    func createSimilar(movieId: Int) -> URLRequest? {
        let url = "\(baseURL)/\(movieId)/similar"
        return produceRequest(url: url, method: .get, key: apiKey, queryItems: nil)
    }
}
