//
//  TopRatedResponse.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/7/11.
//

import Foundation

struct TopRatedResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
