//
//  HomeDIContainer.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 29/08/2025.
//

import NetworkLayer

final class HomeDIContainer {
    
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    lazy var homeService = HomeAPIService(network: networkService)
    lazy var homeRepository = HomeRepository(service: homeService)
    lazy var homeUseCase = HomeUseCase(repository: homeRepository)
    lazy var getLikedExperiencesUseCase = GetLikedExperiencesUseCase(homeRepository: homeRepository)

    @MainActor
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(
            useCase: homeUseCase,
            getLikedExperiencesUseCase: getLikedExperiencesUseCase
        )
    }
    
    @MainActor
    func makeHomeView() -> HomeView {
        HomeView(viewModel: self.makeHomeViewModel())
    }
}
