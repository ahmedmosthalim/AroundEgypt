//
//  ExperienceDetailsViewModelTest.swift
//  AroundEgyptUITests
//
//  Created by Ahmed Mostafa on 31/08/2025.
//

import Foundation
@testable import AroundEgypt
import XCTest


@MainActor
final class ExperienceDetailsViewModelTest: XCTestCase {

    private var mockUseCase: MockFetchAnExperinceUseCase!
    private var mockLikeUseCase: MockLikeAnExperienceUseCase!
    private var mockGetLikesUseCase: MockGetLikedExperiencesUseCase!
    private var mocksaveLikesUseCase: MockSaveLikedExperiencesUseCase!
    
    private var viewModel: ExperienceDetailsViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockUseCase = MockFetchAnExperinceUseCase()
        mockLikeUseCase = MockLikeAnExperienceUseCase()
        mockGetLikesUseCase = MockGetLikedExperiencesUseCase()
        mocksaveLikesUseCase = MockSaveLikedExperiencesUseCase()
        viewModel = ExperienceDetailsViewModel(
            experinceID: "123",
            fetchAnExperinceUseCase: mockUseCase,
            likeAnExperinceUseCase: mockLikeUseCase,
            saveLisaveLikedExperiencesUseCase: mocksaveLikesUseCase,
            getLikedExperiencesUseCase: mockGetLikesUseCase
        )
    }

    override func tearDownWithError() throws {
        mockUseCase = nil
        viewModel = nil
        try super.tearDownWithError()
    }

    func test_FetchAnExperince_success() async {
        mockUseCase.dataToReturn = MockData.experience
        await viewModel.fetchExperienceByID(id: "123")
        try? await Task.sleep(nanoseconds: 100_000_000)

        XCTAssertNotNil(viewModel.experience)
    }
    func test_LikeAnExperince_success() async {
        mockLikeUseCase.dataToReturn = 12
        let result = try? await viewModel.likeAnExperinceUseCase.excute(id: "123")
        try? await Task.sleep(nanoseconds: 100_000_000)

        XCTAssertEqual(result, 12)
    }

    func test_FetchAnExperince__failure() async {
        mockUseCase.errorToThrow = URLError(.badServerResponse)

        await viewModel.fetchExperienceByID(id: "123")
        try? await Task.sleep(nanoseconds: 100_000_000)

        XCTAssertNotNil(viewModel.error)
        XCTAssertFalse(viewModel.isLoading)
    }
    func test_LikeAnExperince_failure_setsError() async {
        mockLikeUseCase.errorToThrow = URLError(.badServerResponse)

        let result = try? await viewModel.likeAnExperinceUseCase.excute(id: "123")
        try? await Task.sleep(nanoseconds: 100_000_000)

        XCTAssertNil(result)
    }
}
