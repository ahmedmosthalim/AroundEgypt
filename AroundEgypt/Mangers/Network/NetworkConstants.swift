//
//  Constants.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 29/08/2025.
//

import Foundation

enum NetworkConstants {
    static let baseHomeHost = "aroundegypt.34ml.com"
    static let baseSearchHost = "mock.apidog.com"
    
    enum Path {
        static let searchPath = "api/v2/experiences"
        static let recommendedExperiences = "api/v2/experiences"
        static let recentExperiences = "api/v2/experiences"
        static let fetchAnExperience = "api/v2/experiences"
        static let likeExperience = "/api/v2/experiences"
    }
    
    enum QueryKey {
        static let filter = "filter"
    }
}
