//
//  RequestConfig.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/12.
//

import Foundation

struct RequestConfig {
    let baseURL: String
    let apiKey: String
    let language: String
    let method: String
    
    static let `default` = RequestConfig(
        baseURL: "https://api.themoviedb.org/3/movie/",
        apiKey: "aefd8f383ce4794e8c98eb8132c161ca",
        language: "en",
        method: "GET"
    )
}
