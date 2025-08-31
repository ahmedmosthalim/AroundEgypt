//
//  HomeServiceContract.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 29/08/2025.
//

import Foundation

protocol HomeAPIServiceContract {
    func fetchMostRecentExperiences() async throws -> ExperiencesResponse
    func fetchRecommendedExperiences() async throws -> ExperiencesResponse
    func fetchExperiencesBySearch(title:String) async throws -> ExperiencesResponse
}
