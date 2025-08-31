//
//  MockHomeAPIService.swift
//  AroundEgyptUITests
//
//  Created by Ahmed Mostafa on 31/08/2025.
//

import Foundation
import Combine
@testable import AroundEgypt


final class MockHomeAPIService: HomeAPIServiceContract {
    
    @Published var dataToReturn: ExperiencesResponse?
    var errorToThrow: Error?

    func fetchExperiencesBySearch(title: String) async throws -> ExperiencesResponse {
        if let error = errorToThrow {
            throw error
        }
        return dataToReturn!
    }
    
    func fetchMostRecentExperiences() async throws -> ExperiencesResponse {
        if let error = errorToThrow {
            throw error
        }
        return dataToReturn!
    }
    
    func fetchRecommendedExperiences() async throws -> ExperiencesResponse {
        if let error = errorToThrow {
            throw error
        }
        return dataToReturn!
    }
}
