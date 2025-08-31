//
//  ExperienceDetailsRepository.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 29/08/2025.
//

import Foundation
import Network
import CoreData


final class ExperienceDetailsRepository: ExperienceDetailsRepositoryContract {
    private let service: DetailsServiceContract
    private let coreDataManger: CoreDataManger
    private let userDefaultsManger: UserDefaultsManger
    private let networkMonitor: NetworkMonitorContract


    init(
        service: DetailsServiceContract,
        coreDataManger: CoreDataManger = .shared,
        userDefaultsManger: UserDefaultsManger = .shared,
        networkMonitor: NetworkMonitorContract = NetworkMonitor()
    ) {
        self.service = service
        self.coreDataManger = coreDataManger
        self.userDefaultsManger = userDefaultsManger
        self.networkMonitor = networkMonitor
    }
    
    func fetchExperienceByID(id: String) async throws -> ExperienceDetail {
        if networkMonitor.isConnected {
            do {
                return try await service.fetchAnExperience(id: id).data
            } catch let error {
                throw error
            }
        } else {
            let result = coreDataManger.fetchExperiences(type: Constants.recent)
            guard let experience = result.first(where: { $0.id == id }) else {
                throw ExperienceError.notFoundLocally
            }
            return ExperienceDetail(
                id: experience.id,
                title: experience.title,
                coverPhoto: experience.coverPhoto,
                description: experience.description,
                viewsNo: experience.viewsNo,
                likesNo: experience.likesNo,
                recommended: experience.recommended,
                tourHtml: experience.tourHml ?? ""
            )
        }
    }
    
    func likeExperience(id: String) async throws -> Int {
        do {
            return try await service.likeAnExperience(id: id).data
        } catch let error {
            throw error
        }
    }
    
    func getLikedExperiences()  -> [String: Bool] {
        userDefaultsManger.loadLikedExperiences() ?? [:]
    }
    
    func saveLikedExperiences(likedExperiences: [String : Bool]) {
        userDefaultsManger.saveLikedExperiences(likedExperiences: likedExperiences)
    }
    
    private enum Constants {
        static let recommended: String = "Recommended"
        static let recent: String = "Recent"
    }
}

enum ExperienceError: Error, LocalizedError {
    case notFoundLocally
    
    var errorDescription: String? {
        switch self {
        case .notFoundLocally:
            return "Experience not available offline"
        }
    }
}
