//
//  ExperienceDICointainer.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 29/08/2025.
//

import NetworkLayer

final class ExperienceDICointainer {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    lazy var homeService = DetailsService(network: networkService)
    lazy var expDetailsRepository = ExperienceDetailsRepository(service: homeService)
    lazy var fetchAnExperience = FetchAnExperinceUseCase(repository: expDetailsRepository)
    lazy var likeAnExperince = LikeAnExperienceUseCase(repository: expDetailsRepository)
    lazy var getLiked = GetLikedExperiencesUseCase(repository: expDetailsRepository)
    lazy var savelike = saveLikedExperiencesUseCase(repository: expDetailsRepository)

    @MainActor
    func makeExpDetailsViewModel(id:String) -> ExperienceDetailsViewModel {
        ExperienceDetailsViewModel(
            experinceID: id,
            fetchAnExperinceUseCase: fetchAnExperience,
            likeAnExperinceUseCase: likeAnExperince,
            saveLisaveLikedExperiencesUseCase: savelike,
            getLikedExperiencesUseCase: getLiked
        )
    }
    
    @MainActor
    func makeDetailsView(id:String) -> ExperienceDetailsView {
        ExperienceDetailsView(viewModel: self.makeExpDetailsViewModel(id: id))
    }
}
