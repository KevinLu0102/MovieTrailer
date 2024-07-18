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
    private let language: String?
    private let iso3166: String?
    private let iso639: String?
    private let requestProducer: RequestProducerProtocol
    
    init(apiConfig: APICongigProtocol, languageRegion: LanguageRegionProtocol, requestProducer: RequestProducerProtocol) {
        self.baseURL = apiConfig.baseURL
        self.apiKey = apiConfig.apiKey
        self.language = languageRegion.language
        self.iso3166 = languageRegion.iso3166
        self.iso639 = languageRegion.iso639
        self.requestProducer = requestProducer
    }
    
    func createPopular() -> URLRequest? {
        let url = "\(baseURL)/popular"
        let queryItems = [URLQueryItem(name: "language", value: language), URLQueryItem(name: "region", value: iso3166)]
        return requestProducer.produceRequest(url: url, method: .get, key: apiKey, queryItems: queryItems)
    }
    
    func createUpcoming() -> URLRequest? {
        let url = "\(baseURL)/upcoming"
        let queryItems = [URLQueryItem(name: "language", value: language), URLQueryItem(name: "region", value: iso3166)]
        return requestProducer.produceRequest(url: url, method: .get, key: apiKey, queryItems: queryItems)
    }
    
    func createTopRated() -> URLRequest? {
        let url = "\(baseURL)/top_rated"
        let queryItems = [URLQueryItem(name: "language", value: language), URLQueryItem(name: "region", value: iso3166)]
        return requestProducer.produceRequest(url: url, method: .get, key: apiKey, queryItems: queryItems)
    }
    
    func createDetail(movieId: Int) -> URLRequest? {
        let url = "\(baseURL)/\(movieId)"
        let queryItems = [URLQueryItem(name: "language", value: language)]
        return requestProducer.produceRequest(url: url, method: .get, key: apiKey, queryItems: queryItems)
    }
    
    func createVideo(movieId: Int) -> URLRequest? {
        let url = "\(baseURL)/\(movieId)/videos"
        return requestProducer.produceRequest(url: url, method: .get, key: apiKey, queryItems: nil)
    }
    
    func createImages(movieId: Int) -> URLRequest? {
        let url = "\(baseURL)/\(movieId)/images"
        let queryItems = [URLQueryItem(name: "include_image_language", value: iso639)]
        return requestProducer.produceRequest(url: url, method: .get, key: apiKey, queryItems: queryItems)
    }
    
    func createSimilar(movieId: Int) -> URLRequest? {
        let url = "\(baseURL)/\(movieId)/similar"
        let queryItems = [URLQueryItem(name: "language", value: language)]
        return requestProducer.produceRequest(url: url, method: .get, key: apiKey, queryItems: queryItems)
    }
}
