//
//  DetailsService.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 29/08/2025.
//

import Foundation
import NetworkLayer


struct DetailsService: DetailsServiceContract {
    private let network: NetworkService

    init(network: NetworkService) {
        self.network = network
    }
    
    func fetchAnExperience(id: String) async throws -> ExperienceDetailResponse {
        let request = DetailsNetworkRequest(type: .fetchAnExperience(id: id))
        return try await network.request(request, decodeTo: ExperienceDetailResponse.self)
    }
    
    func likeAnExperience(id: String) async throws -> LikeResponse {
        let request = DetailsNetworkRequest(type: .likeAnExperience(id: id))
        return try await network.request(request, decodeTo: LikeResponse.self)
    }
    
}
