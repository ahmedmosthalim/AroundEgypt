//
//  HomeRepositoryContract.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 29/08/2025.
//


import Foundation

protocol HomeRepositoryContract {
    func fetchMostRecentExperiences() async throws -> [Experience]
    func fetchRecommendedExperiences() async throws -> [Experience]
    func fetchExperiencesBySearch(title:String) async throws -> [Experience]
    func getLikedExperiences()  -> [String: Bool]
}

