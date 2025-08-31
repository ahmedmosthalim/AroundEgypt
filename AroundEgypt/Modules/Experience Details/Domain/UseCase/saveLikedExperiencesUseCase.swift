//
//  saveLikedExperiencesUseCase.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 30/08/2025.
//

import Foundation

final class saveLikedExperiencesUseCase: SaveLikedExperiencesUseCaseContract {
    private let repository: ExperienceDetailsRepositoryContract
    
    init(repository: ExperienceDetailsRepositoryContract) {
        self.repository = repository
    }
    
    func excute(list: [String : Bool]) {
        self.repository.saveLikedExperiences(likedExperiences: list)
    }
}
