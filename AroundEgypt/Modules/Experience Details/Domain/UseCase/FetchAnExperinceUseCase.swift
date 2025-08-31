//
//  FetchAnExperinceUseCase.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 29/08/2025.
//

import Foundation

final class FetchAnExperinceUseCase: FetchAnExperinceUseCaseContract {
    private let repository: ExperienceDetailsRepositoryContract
    
    init(repository: ExperienceDetailsRepositoryContract) {
        self.repository = repository
    }
    
    func excute(id: String) async throws -> ExperienceDetail {
        try await repository.fetchExperienceByID(id: id)
    }
}
