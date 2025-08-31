//
//  LikeAnExperienceUseCase.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 29/08/2025.
//

import Foundation

final class LikeAnExperienceUseCase: LikeAnExperienceUseCaseContract {
    private let repository: ExperienceDetailsRepositoryContract
    
    init(repository: ExperienceDetailsRepositoryContract) {
        self.repository = repository
    }
    
    func excute(id: String) async throws -> Int {
        try await repository.likeExperience(id: id)
    }
}
