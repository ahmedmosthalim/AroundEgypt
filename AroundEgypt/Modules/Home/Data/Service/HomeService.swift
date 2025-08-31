//
//  HomeService.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 29/08/2025.
//

import Foundation
import NetworkLayer


struct HomeAPIService: HomeAPIServiceContract {
    private let network: NetworkService

    init(network: NetworkService) {
        self.network = network
    }
    
    func fetchMostRecentExperiences() async throws -> ExperiencesResponse {
        let request = HomeNetworkRequest(type: .recent)
        return try await network.request(request, decodeTo: ExperiencesResponse.self)
    }
    
    func fetchRecommendedExperiences() async throws -> ExperiencesResponse {
        let request = HomeNetworkRequest(type: .recommended)
        return try await network.request(request, decodeTo: ExperiencesResponse.self)
    }
    
    func fetchExperiencesBySearch(title:String) async throws -> ExperiencesResponse {
        let request = HomeNetworkRequest(type: .search(title: title))
        return try await network.request(request, decodeTo: ExperiencesResponse.self)
    }
}
