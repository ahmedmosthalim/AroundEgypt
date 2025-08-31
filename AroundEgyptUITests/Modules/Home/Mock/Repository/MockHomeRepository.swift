//
//  MockHomeRepository.swift
//  AroundEgyptUITests
//
//  Created by Ahmed Mostafa on 31/08/2025.
//

import Foundation
import Combine
@testable import AroundEgypt


final class MockHomeRepository: HomeRepositoryContract {
    
    var dataToReturn: [Experience]?
    var likedExperiencesToReturn: [String : Bool]?
    var errorToThrow: Error?
    
    
    func getLikedExperiences() -> [String : Bool] {
        if let error = errorToThrow {
            return [:]
        } else {
            return likedExperiencesToReturn!
        }
    }
    
    

    func fetchExperiencesBySearch(title: String) async throws -> [Experience] {
        if let error = errorToThrow {
            throw error
        }
        return dataToReturn!
    }
    func fetchMostRecentExperiences() async throws -> [Experience] {
        if let error = errorToThrow {
            throw error
        }
        return dataToReturn!
    }
    func fetchRecommendedExperiences() async throws -> [Experience] {
        if let error = errorToThrow {
            throw error
        }
        return dataToReturn!
    }
}
