//
//  MovieAPIConfig.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/7/18.
//

import Foundation

protocol APICongigProtocol {
    var baseURL: String { get }
    var apiKey: String { get }
}

struct MovieAPIConfig: APICongigProtocol{
    var baseURL: String = "https://api.themoviedb.org/3/movie"
    var apiKey: String = "aefd8f383ce4794e8c98eb8132c161ca"
}
