//
//  HomeUseCaseTests.swift
//  AroundEgyptUITests
//
//  Created by Ahmed Mostafa on 31/08/2025.
//

import Foundation
import Combine
@testable import AroundEgypt
import XCTest


final class HomeUseCaseTests: XCTestCase {

    private var mockRepo: MockHomeRepository!
    private var useCase: HomeUseCase!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockRepo = MockHomeRepository()
        useCase = HomeUseCase(repository: mockRepo)
    }

    override func tearDownWithError() throws {
        mockRepo = nil
        useCase = nil
        try super.tearDownWithError()
    }

    func test_fetchRecommendedExperiences_success() async throws {
        // Act
        mockRepo.dataToReturn = MockData.experiences
        let result = try await useCase.fetchRecommendedExperiences()

        // Assert
        XCTAssertEqual(result.count, 2)
    }
    
    func test_fetchMostRecentExperiences_success() async throws {
        // Act
        mockRepo.dataToReturn = MockData.experiences
        let result = try await useCase.fetchMostRecentExperiences()

        // Assert
        XCTAssertEqual(result.count, 2)
    }

    func test_fetchRecommendedExperiences_failure_throwsError() async {
        // Arrange
        mockRepo.errorToThrow = URLError(.notConnectedToInternet)

        // Act & Assert
        do {
            _ = try await useCase.fetchRecommendedExperiences()
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }
    
    func test_fetchMostRecentExperiences_failure_throwsError() async {
        // Arrange
        mockRepo.errorToThrow = URLError(.notConnectedToInternet)

        // Act & Assert
        do {
            _ = try await useCase.fetchMostRecentExperiences()
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }
}
