//
//  MockHomeUseCase.swift
//  AroundEgyptUITests
//
//  Created by Ahmed Mostafa on 31/08/2025.
//

import Foundation
@testable import AroundEgypt

final class MockHomeUseCase: HomeUseCaseContract {
    var dataToReturn: [Experience]?
    var errorToThrow: Error?

    func fetchExperiencesBySearch(title: String) async throws -> [Experience] {
        if let error = errorToThrow {
            throw error
        }
        return dataToReturn ?? []
    }
    func fetchMostRecentExperiences() async throws -> [Experience] {
        if let error = errorToThrow {
            throw error
        }
        return dataToReturn ?? []
    }
    func fetchRecommendedExperiences() async throws -> [Experience] {
        if let error = errorToThrow {
            throw error
        }
        return dataToReturn ?? []
    }
}
