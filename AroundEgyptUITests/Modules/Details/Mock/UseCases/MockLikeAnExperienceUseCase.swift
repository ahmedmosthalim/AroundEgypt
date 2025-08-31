//
//  MockLikeAnExperienceUseCase.swift
//  AroundEgyptUITests
//
//  Created by Ahmed Mostafa on 31/08/2025.
//

import Foundation
@testable import AroundEgypt

final class MockLikeAnExperienceUseCase : LikeAnExperienceUseCaseContract {
    var dataToReturn: Int?
    var errorToThrow: Error?
    
    func excute(id: String) async throws -> Int {
        if let error = errorToThrow {
            throw error
        } else {
            return dataToReturn ?? 1
        }
    }
}
