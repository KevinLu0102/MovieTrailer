//
//  APIRequest.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/12.
//

import Foundation

protocol APIRequestProtocol {
    func upcoming(page: Int) -> URLRequest?
}

fileprivate enum Path: String {
    case upcoming
}

struct APIRequest: APIRequestProtocol {
    private let baseURL: String
    private let apiKey: String
    private let language: String
    private let method: String
    
    init(config: RequestConfig = .default) {
        self.baseURL = config.baseURL
        self.apiKey = config.apiKey
        self.language = config.language
        self.method = config.method
    }
    
    private func makeRequest(path: Path, queryItems: [URLQueryItem] = []) -> URLRequest? {
        guard let url = URL(string: baseURL + path.rawValue)else{
            return nil
        }
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        let defaultQueryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: language),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        components.queryItems = components.queryItems.map { $0 + defaultQueryItems + queryItems } ?? defaultQueryItems + queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json"
        ]
        
        return request
    }
    
    func upcoming(page: Int) -> URLRequest? {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "page", value: "\(page)")
        ]
        return makeRequest(path: .upcoming, queryItems: queryItems)
    }
}
