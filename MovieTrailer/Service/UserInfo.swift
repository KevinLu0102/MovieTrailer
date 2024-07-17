//
//  UserInfo.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/7/17.
//

import Foundation

protocol UserSystemInfoProtocol {
    var language: String? { get }
    var iso3166: String? { get }
    var iso639: String? { get }
}

class UserInfo: UserSystemInfoProtocol {
    private(set) var language: String?
    private(set) var iso3166: String?
    private(set) var iso639: String?

    static let shared = UserInfo()
    
    private init() {
        guard let preferred = Locale.preferredLanguages.first else {
            return
        }
        
        guard let language = Locale(identifier: preferred).language.languageCode?.identifier else{
            return
        }
        
        guard let region = Locale(identifier: preferred).language.region?.identifier else{
            return
        }
        
        self.language = language + "-" + region
        self.iso3166 = region
        self.iso639 = language
    }
}
