//
//  Video.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/12.
//

import Foundation

struct VideoResponse: Codable {
    let id: Int
    let results: [Video]
}

struct Video: Codable, Identifiable {
    let iso6391: String
    let iso31661: String
    let name: String
    let key: String
    let site: String
    let size: Int
    private let type: String
    let official: Bool
    let publishedAt: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case iso6391 = "iso_639_1"
        case iso31661 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
    
    enum VideoType{
        case trailer
        case teaser
        case others
    }
    
    var isOfficialTrailer: Bool{
        return name.contains("Official") && videoType == .trailer
    }
    
    var videoType: VideoType {
        switch type {
        case "Trailer":
            return .trailer
        case "Teaser":
            return .teaser
        default:
            return .others
        }
    }
    
}
