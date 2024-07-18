//
//  LanguageRegion.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/7/17.
//

import Foundation

protocol LanguageRegionProtocol {
    var iso3166: String? { get }
    var iso639: String? { get }
    var language: String? { get }
}

enum LanguageOption {
    case zhTW
    case enTW
    case system
}

struct LanguageRegion: LanguageRegionProtocol {
    private let option: LanguageOption
    
    private(set) var iso3166: String?
    private(set) var iso639: String?
    private(set) var language: String?
    
    init(option: LanguageOption) {
        self.option = option
        
        switch option {
        case .zhTW:
            self.iso3166 = "TW"
            self.iso639 = "zh"
            self.language = "zh-TW"
        case .enTW:
            self.iso3166 = "TW"
            self.iso639 = "en"
            self.language = "en-TW"
        case .system:
            guard let preferred = Locale.preferredLanguages.first else {
                return
            }
            let locale = Locale(identifier: preferred)
            
            guard let language = locale.language.languageCode?.identifier else {
                return
            }
            self.iso639 = language
            
            guard let region = locale.language.region?.identifier else {
                return
            }
            self.iso3166 = region
            self.language = "\(language)-\(region)"
        }
    }
}
