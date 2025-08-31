//
//  AppDIContainer.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 29/08/2025.
//
import Foundation
import NetworkLayer

final class AppDIContainer: DIContainer, ObservableObject {
    
    lazy var networkService: NetworkService = URLSessionNetworkService()
    
    lazy var homeContainer: HomeDIContainer = {
        HomeDIContainer(networkService: networkService)
    }()
    
    lazy var experienceContainer: ExperienceDICointainer = {
        ExperienceDICointainer(networkService: networkService)
    }()
    
    @MainActor
    func makeHomeView() -> HomeView {
        homeContainer.makeHomeView()
    }
    
    @MainActor
    func makeDetailsView(id:String) -> ExperienceDetailsView {
        experienceContainer.makeDetailsView(id:id)
    }
}
