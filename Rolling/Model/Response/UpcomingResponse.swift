//
//  Upcoming.swift
//  Rolling
//
//  Created by Kevin Lu on 2024/6/11.
//

import Foundation

struct UpcomingResponse: Codable {
    let dates: Dates
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case dates
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Dates: Codable {
    let maximum: String
    let minimum: String
}
