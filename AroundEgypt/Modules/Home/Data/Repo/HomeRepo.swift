//
//  HomeRepo.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 29/08/2025.
//

import Foundation
import Network
import CoreData


final class HomeRepository: HomeRepositoryContract {
    private let service: HomeAPIServiceContract
    private let coreDataManger: CoreDataManger
    private let userDefaultsManger: UserDefaultsManger
    private let networkMonitor: NetworkMonitorContract
    
    init(
        service: HomeAPIServiceContract,
        coreDataManger: CoreDataManger = .shared,
        userDefaultsManger: UserDefaultsManger = .shared,
        networkMonitor: NetworkMonitorContract = NetworkMonitor()
    ) {
        self.service = service
        self.coreDataManger = coreDataManger
        self.userDefaultsManger = userDefaultsManger
        self.networkMonitor = networkMonitor
    }
    
    func fetchMostRecentExperiences() async throws -> [Experience] {
        if networkMonitor.isConnected {
            do {
                let result = try await service.fetchMostRecentExperiences().data
                coreDataManger.clearExperiences(ofType: Constants.recent)
                for experience in result {
                    coreDataManger.saveExperience(experience: experience, type: Constants.recent)
                }
                return result
            } catch let error {
                throw error
            }
        } else {
            return coreDataManger.fetchExperiences(type: Constants.recent)
        }
    }
    
    func fetchRecommendedExperiences() async throws -> [Experience] {
        if networkMonitor.isConnected {
            do {
                let result = try await service.fetchRecommendedExperiences().data
                coreDataManger.clearExperiences(ofType: Constants.recommended)
                for experience in result {
                    coreDataManger.saveExperience(experience: experience, type: Constants.recommended)
                }
                return result
            } catch let error {
                throw error
            }
        } else {
            return coreDataManger.fetchExperiences(type: Constants.recommended)
        }
    }
    
    func fetchExperiencesBySearch(title:String) async throws -> [Experience] {
        do {
            return try await service.fetchExperiencesBySearch(title: title).data
        } catch let error {
            throw error
        }
    }
    
    func getLikedExperiences()  -> [String: Bool] {
        userDefaultsManger.loadLikedExperiences() ?? [:]
    }
    
    private enum Constants {
        static let recommended: String = "Recommended"
        static let recent: String = "Recent"
    }
}

