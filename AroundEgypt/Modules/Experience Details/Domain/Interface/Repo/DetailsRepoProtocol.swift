//
//  DetailsRepoContract.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 29/08/2025.
//

import Foundation

protocol ExperienceDetailsRepositoryContract {
    func likeExperience(id:String) async throws -> Int
    func fetchExperienceByID(id:String) async throws -> ExperienceDetail
    func getLikedExperiences()  -> [String: Bool]
    func saveLikedExperiences(likedExperiences: [String: Bool])
    
}
