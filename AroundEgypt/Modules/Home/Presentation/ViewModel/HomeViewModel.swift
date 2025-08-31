//
//  HomeViewModel.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 29/08/2025.
//

import Foundation
import Combine
import Network
import SwiftUI


@MainActor
final class HomeViewModel: ObservableObject {
    
    @Published var recommendedExperiences: [Experience] = []
    @Published var recentExperiences: [Experience] = []
    @Published var searchResults: [Experience] = []
    
    @Published var likedExperiences: [String: Bool] = [:]
    
    @Published var error: String?
    @Published var isLoading = false
    @Published var isSheetPresented = false
    @Published var isImageLoaded: Bool = false

    private var fetchTask: Task<Void, Never>?
    private let networkMonitor: NetworkMonitorContract
    private let useCase: HomeUseCaseContract
    let getLikedExperiencesUseCase: GetLikedExperiencesUseCaseContract
    
    init(
        useCase: HomeUseCaseContract,
        getLikedExperiencesUseCase: GetLikedExperiencesUseCaseContract,
        networkMonitor: NetworkMonitorContract = NetworkMonitor()
    ) {
        self.useCase = useCase
        self.getLikedExperiencesUseCase = getLikedExperiencesUseCase
        self.networkMonitor = networkMonitor
    }
}

// MARK: - Networking

extension HomeViewModel {
    func fetchHome() async {
        cancelTask()
        fetchTask = Task {
            await fetchRecent()
            await fetchRecommended()
            getLikedExperiences()
            cancelTask()
        }
        if !networkMonitor.isConnected {
            cancelTask()
            isImageLoaded = true
        }

    }
    
    private func fetchRecent() async {
        guard !isLoading else { return }
        isLoading = true
        do {
            self.recentExperiences = try await useCase.fetchMostRecentExperiences()
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
    
    private func fetchRecommended() async {
        guard !isLoading else { return }
        isLoading = true
        do {
            self.recommendedExperiences = try await useCase.fetchRecommendedExperiences()
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
    
    private func getLikedExperiences(){
        self.likedExperiences =  getLikedExperiencesUseCase.excute()
    }
    
    func fetchByTitle(title:String) async {
        guard !isLoading else { return }
        isLoading = true
        do {
            let resutlt = try await useCase.fetchExperiencesBySearch(title: title)
            self.searchResults = resutlt
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
    
    private func cancelTask() {
        fetchTask?.cancel()
        fetchTask = nil
    }
}
