//
//  HomeUseCase.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 29/08/2025.
//

import Foundation

final class HomeUseCase: HomeUseCaseContract {
    
    private let repository: HomeRepositoryContract
    init(repository: HomeRepositoryContract) {
        self.repository = repository
    }
    
    func fetchMostRecentExperiences() async throws -> [Experience] {
        try await repository.fetchMostRecentExperiences()
    }
    
    func fetchRecommendedExperiences() async throws -> [Experience] {
        try await repository.fetchRecommendedExperiences()
    }
    
    func fetchExperiencesBySearch(title:String) async throws -> [Experience] {
        try await repository.fetchExperiencesBySearch(title: title)
    }
    
}
