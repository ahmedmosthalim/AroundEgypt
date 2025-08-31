//
//  getLikedExperiencesUseCase.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 30/08/2025.
//

import Foundation

class GetLikedExperiencesUseCase: GetLikedExperiencesUseCaseContract {
    private let repository: ExperienceDetailsRepositoryContract?
    private let homeRepository: HomeRepositoryContract?
    
    init(repository: ExperienceDetailsRepositoryContract) {
        self.repository = repository
        self.homeRepository = nil
    }
    
    init(homeRepository: HomeRepositoryContract) {
        self.homeRepository = homeRepository
        self.repository = nil
    }
    
    func excute() -> [String: Bool] {
        if let repository = repository {
            return repository.getLikedExperiences()
        } else if let homeRepository = homeRepository {
            return homeRepository.getLikedExperiences()
        } else {
            return [:]
        }
    }
}
