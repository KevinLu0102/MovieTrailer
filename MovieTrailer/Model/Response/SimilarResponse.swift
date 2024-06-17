//
//  SimilarResponse.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/17.
//

import Foundation

struct SimilarResponse: Codable {
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
