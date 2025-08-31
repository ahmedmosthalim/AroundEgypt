//
//  MockDetailsService.swift
//  AroundEgyptUITests
//
//  Created by Ahmed Mostafa on 31/08/2025.
//

import Foundation
import Combine
@testable import AroundEgypt


final class MockDetailsService: DetailsServiceContract {
    
    @Published var fetchAnExperienceData: ExperienceDetailResponse?
    @Published var likeAnExperienceData: LikeResponse?
    var errorToThrow: Error?
    
    func fetchAnExperience(id: String) async throws -> ExperienceDetailResponse {
        if let error = errorToThrow {
            throw error
        }
        return fetchAnExperienceData!
    }
    
    func likeAnExperience(id: String) async throws -> LikeResponse {
            if let error = errorToThrow {
                throw error
            }
            return likeAnExperienceData!
        }
}
