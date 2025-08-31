//
//  MockDetailsRepo.swift
//  AroundEgyptUITests
//
//  Created by Ahmed Mostafa on 31/08/2025.
//

import Foundation
import Combine
@testable import AroundEgypt


final class MockDetailsRepo: ExperienceDetailsRepositoryContract {
    
    var dataToReturn: ExperienceDetail?
    var numberOfLikes: Int?
    var likedExperiencesToReturn: [String : Bool]?
    var errorToThrow: Error?
    
    func fetchExperienceByID(id: String) async throws -> ExperienceDetail {
        if let error = errorToThrow {
            throw error
        }
        return dataToReturn!
    }
    
    func likeExperience(id: String) async throws -> Int {
        if let error = errorToThrow {
            throw error
        }
        return numberOfLikes!
    }
    
    func getLikedExperiences() -> [String : Bool] {
        if let error = errorToThrow {
            return [:]
        } else {
            return likedExperiencesToReturn!
        }
    }
    
    func saveLikedExperiences(likedExperiences: [String : Bool]) {
        
    }
}
