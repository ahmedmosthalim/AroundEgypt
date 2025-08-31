//
//  ExperienceDetailsViewModel.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 29/08/2025.
//

import Foundation
import Combine

@MainActor
final class ExperienceDetailsViewModel: ObservableObject {
    
    var experinceID: String?
    @Published var experience: ExperienceDetail?
    @Published var error: String?
    @Published var isLoading = false
    @Published var isImageLoaded = false
    @Published var likedExperiences: [String: Bool] = [:]

    let fetchAnExperinceUseCase: FetchAnExperinceUseCaseContract
    let likeAnExperinceUseCase: LikeAnExperienceUseCaseContract
    let saveLisaveLikedExperiencesUseCase: SaveLikedExperiencesUseCaseContract
    let getLikedExperiencesUseCase: GetLikedExperiencesUseCaseContract
    var fetchTask: Task<Void, Never>?
    

    init(
        experinceID: String,
        fetchAnExperinceUseCase: FetchAnExperinceUseCaseContract,
        likeAnExperinceUseCase: LikeAnExperienceUseCaseContract,
        saveLisaveLikedExperiencesUseCase: SaveLikedExperiencesUseCaseContract,
        getLikedExperiencesUseCase: GetLikedExperiencesUseCaseContract
    ) {
        self.experinceID = experinceID
        self.fetchAnExperinceUseCase = fetchAnExperinceUseCase
        self.likeAnExperinceUseCase = likeAnExperinceUseCase
        self.saveLisaveLikedExperiencesUseCase = saveLisaveLikedExperiencesUseCase
        self.getLikedExperiencesUseCase = getLikedExperiencesUseCase
    }
    
    func fetchExperienceByID(id: String) async {
        guard !isLoading else { return }
        isLoading = true
        do {
            let result = try await fetchAnExperinceUseCase.excute(id: id)
            getLikedExperinces()
            self.experience = result
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
    
    func getLikedExperinces() {
        self.likedExperiences = getLikedExperiencesUseCase.excute()
    }
    
    func likeAnExperince(id:String) async {
        guard !isLoading else { return }
        isLoading = true
        do {
            experience?.likesNo = try await likeAnExperinceUseCase.excute(id: id)
            likedExperiences[experinceID ?? ""] = true
            saveLisaveLikedExperiencesUseCase.excute(list: likedExperiences)
            NotificationCenter.default.post(name: .experienceLikeStatusChanged, object: nil, userInfo: ["experienceId": "\(experinceID ?? "")", "isLiked": true])
            if let exp = experience {
                CoreDataManger.shared.saveExperienceDetail(experience: exp)
            }

        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
    
}
