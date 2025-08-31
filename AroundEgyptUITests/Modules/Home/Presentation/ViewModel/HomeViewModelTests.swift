//
//  HomeViewModelTests.swift
//  AroundEgyptUITests
//
//  Created by Ahmed Mostafa on 31/08/2025.
//

import Foundation
@testable import AroundEgypt
import XCTest


@MainActor
final class HomeViewModelTests: XCTestCase {

    private var mockUseCase: MockHomeUseCase!
    private var mockGetUseCase: MockGetLikedExperiencesUseCase!
    
    private var viewModel: HomeViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockUseCase = MockHomeUseCase()
        mockGetUseCase = MockGetLikedExperiencesUseCase()
        viewModel = HomeViewModel(useCase: mockUseCase, getLikedExperiencesUseCase: mockGetUseCase)
    }

    override func tearDownWithError() throws {
        mockUseCase = nil
        viewModel = nil
        try super.tearDownWithError()
    }

    func test_fetchHome_success_fetchMostRecent() async {
        mockUseCase.dataToReturn = MockData.experiences
        await viewModel.fetchHome()
        try? await Task.sleep(nanoseconds: 100_000_000)

        XCTAssertNotNil(viewModel.recentExperiences)
    }
    func test_fetchHome_success_fetchMostReccommended() async {
        mockUseCase.dataToReturn = MockData.experiences
        await viewModel.fetchHome()
        try? await Task.sleep(nanoseconds: 100_000_000)

        XCTAssertNotNil(viewModel.recommendedExperiences)
    }

    func test_fetchHome_failure_setsError() async {
        mockUseCase.errorToThrow = URLError(.badServerResponse)

        await viewModel.fetchHome()
        try? await Task.sleep(nanoseconds: 100_000_000)

        XCTAssertNotNil(viewModel.error)
    }
}
