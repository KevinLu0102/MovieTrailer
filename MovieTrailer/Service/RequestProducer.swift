//
//  RequestProducer.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/18.
//

import Foundation

protocol RequestProducerProtocol {
    func produceRequest(url: String, method: HTTPMethod, key: String, queryItems: [URLQueryItem]?) -> URLRequest?
}

class RequestProducer: RequestProducerProtocol {
    func produceRequest(url: String, method: HTTPMethod, key: String, queryItems: [URLQueryItem]?) -> URLRequest? {
        guard let url = URL(string: url) else {
            return nil
        }
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        components.queryItems = [URLQueryItem(name: "api_key", value: key)]
        
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
}
