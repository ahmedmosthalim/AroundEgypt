//
//  DetailsServiceContract.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 29/08/2025.
//

import Foundation

protocol DetailsServiceContract {
    func fetchAnExperience(id:String) async throws -> ExperienceDetailResponse
    func likeAnExperience(id:String) async throws -> LikeResponse
}
