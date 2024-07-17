//
//  MovieRequestFactory.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/18.
//

import Foundation

protocol MovieRequestProtocol {
    func createUpcoming() -> URLRequest?
    func createTopRated() -> URLRequest?
    func createDetail(movieId: Int) -> URLRequest?
    func createVideo(movieId: Int) -> URLRequest?
    func createImages(movieId: Int) -> URLRequest?
    func createSimilar(movieId: Int) -> URLRequest?
    func createPopular() -> URLRequest?
}

class MovieRequestFactory: MovieRequestProtocol {
    private let baseURL: String
    private let apiKey: String
    private let userInfo: UserSystemInfoProtocol
    private let requestProducer: RequestProducerProtocol
    
    init(baseURL: String = "https://api.themoviedb.org/3/movie",
         apiKey: String = "aefd8f383ce4794e8c98eb8132c161ca",
         userInfo: UserSystemInfoProtocol = UserInfo.shared,
         requestProducer: RequestProducerProtocol = RequestProducer()) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.userInfo = userInfo
        self.requestProducer = requestProducer
    }
    
    func createPopular() -> URLRequest? {
        let url = "\(baseURL)/popular"
        let queryItems = [URLQueryItem(name: "language", value: userInfo.language), URLQueryItem(name: "region", value: userInfo.iso3166)]
        return requestProducer.produceRequest(url: url, method: .get, key: apiKey, queryItems: queryItems)
    }
    
    func createUpcoming() -> URLRequest? {
        let url = "\(baseURL)/upcoming"
        let queryItems = [URLQueryItem(name: "language", value: userInfo.language), URLQueryItem(name: "region", value: userInfo.iso3166)]
        return requestProducer.produceRequest(url: url, method: .get, key: apiKey, queryItems: queryItems)
    }
    
    func createTopRated() -> URLRequest? {
        let url = "\(baseURL)/top_rated"
        let queryItems = [URLQueryItem(name: "language", value: userInfo.language), URLQueryItem(name: "region", value: userInfo.iso3166)]
        return requestProducer.produceRequest(url: url, method: .get, key: apiKey, queryItems: queryItems)
    }
    
    func createDetail(movieId: Int) -> URLRequest? {
        let url = "\(baseURL)/\(movieId)"
        let queryItems = [URLQueryItem(name: "language", value: userInfo.language)]
        return requestProducer.produceRequest(url: url, method: .get, key: apiKey, queryItems: queryItems)
    }
    
    func createVideo(movieId: Int) -> URLRequest? {
        let url = "\(baseURL)/\(movieId)/videos"
        return requestProducer.produceRequest(url: url, method: .get, key: apiKey, queryItems: nil)
    }
    
    func createImages(movieId: Int) -> URLRequest? {
        let url = "\(baseURL)/\(movieId)/images"
        let queryItems = [URLQueryItem(name: "include_image_language", value: userInfo.iso639)]
        return requestProducer.produceRequest(url: url, method: .get, key: apiKey, queryItems: queryItems)
    }
    
    func createSimilar(movieId: Int) -> URLRequest? {
        let url = "\(baseURL)/\(movieId)/similar"
        let queryItems = [URLQueryItem(name: "language", value: userInfo.language)]
        return requestProducer.produceRequest(url: url, method: .get, key: apiKey, queryItems: queryItems)
    }
}
