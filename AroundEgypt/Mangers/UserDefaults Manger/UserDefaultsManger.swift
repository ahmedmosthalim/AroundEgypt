//
//  UserDefaultsManger.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 30/08/2025.
//

import Foundation


class UserDefaultsManger {

    static let shared = UserDefaultsManger()
    private init() {}

    func loadLikedExperiences() -> [String: Bool]? {
        if let savedLikes = UserDefaults.standard.object(forKey: "likedExperiences") as? [String: Bool] {
            return savedLikes
        } else {
            return [:]
        }
    }
    
    func saveLikedExperiences(likedExperiences: [String: Bool]) {
        UserDefaults.standard.set(likedExperiences, forKey: "likedExperiences")
    }
}
