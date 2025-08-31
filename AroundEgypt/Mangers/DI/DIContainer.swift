//
//  DIContainer.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 29/08/2025.
//
import Foundation
import NetworkLayer

protocol DIContainer: ObservableObject {
    var networkService: NetworkService { get }
    var homeContainer: HomeDIContainer { get }
    var experienceContainer: ExperienceDICointainer { get }
}
