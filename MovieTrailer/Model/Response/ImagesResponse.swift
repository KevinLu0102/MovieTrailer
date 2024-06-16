//
//  ImagesResponse.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/16.
//

import Foundation

struct ImagesResponse: Codable {
    let backdrops: [Backdrop]
    let id: Int
    let logos: [Logo]
    let posters: [Poster]
}

struct Backdrop: Codable {
    let aspectRatio: Double
    let height: Int
    let iso639_1: String?
    let filePath: String
    let voteAverage: Double
    let voteCount: Int
    let width: Int
    
    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case height
        case iso639_1 = "iso_639_1"
        case filePath = "file_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}

struct Logo: Codable {
    let aspectRatio: Double
    let height: Int
    let iso639_1: String?
    let filePath: String
    let voteAverage: Double
    let voteCount: Int
    let width: Int
    
    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case height
        case iso639_1 = "iso_639_1"
        case filePath = "file_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}

struct Poster: Codable {
    let aspectRatio: Double
    let height: Int
    let iso639_1: String?
    let filePath: String
    let voteAverage: Double
    let voteCount: Int
    let width: Int
    
    var filePathURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(filePath)")
    }
    
    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case height
        case iso639_1 = "iso_639_1"
        case filePath = "file_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
    
}
