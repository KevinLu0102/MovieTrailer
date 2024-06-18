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
    private let requestProducer: RequestProducerProtocol
    
    init(baseURL: String = "https://api.themoviedb.org/3/movie",
         apiKey: String = "aefd8f383ce4794e8c98eb8132c161ca",
         language: String = "en",
         requestProducer: RequestProducerProtocol = RequestProducer()) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.language = language
        self.requestProducer = requestProducer
    }
    
    func createUpcoming(page: Int) -> URLRequest? {
        let queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        let url = "\(baseURL)/upcoming"
        return requestProducer.produceRequest(url: url, method: .get, key: apiKey, queryItems: queryItems)
    }
    
    func createDetail(movieId: Int) -> URLRequest? {
        let url = "\(baseURL)/\(movieId)"
        return requestProducer.produceRequest(url: url, method: .get, key: apiKey, queryItems: nil)
    }
    
    func createVideo(movieId: Int) -> URLRequest? {
        let url = "\(baseURL)/\(movieId)/videos"
        return requestProducer.produceRequest(url: url, method: .get, key: apiKey, queryItems: nil)
    }
    
    func createImages(movieId: Int) -> URLRequest? {
        let url = "\(baseURL)/\(movieId)/images"
        return requestProducer.produceRequest(url: url, method: .get, key: apiKey, queryItems: nil)
    }
    
    func createSimilar(movieId: Int) -> URLRequest? {
        let url = "\(baseURL)/\(movieId)/similar"
        return requestProducer.produceRequest(url: url, method: .get, key: apiKey, queryItems: nil)
    }
}
