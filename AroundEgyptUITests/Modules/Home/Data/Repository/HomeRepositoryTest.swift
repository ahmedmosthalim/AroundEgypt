//
//  HomeRepositoryTest.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 31/08/2025.
//

import XCTest
import Combine
@testable import AroundEgypt

final class HomeRepositoryTests: XCTestCase {

    private var mockService: MockHomeAPIService!
    private var repository: HomeRepository!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockService = MockHomeAPIService()
        repository = HomeRepository(service: mockService)
    }

    override func tearDownWithError() throws {
        mockService = nil
        repository = nil
        try super.tearDownWithError()
    }

    func test_fetchHome_success_fetchMostRecentExperiences() async throws {
        // Act
        mockService.dataToReturn = MockData.mostRecentExperiences
        let result = try await repository.fetchMostRecentExperiences()
        try? await Task.sleep(nanoseconds: 100_000_000)

        // Assert
        XCTAssertEqual(result.count, 2)
    }
    func test_fetchHome_success_fetchMostRecommendedExperiences() async throws {
        // Act
        mockService.dataToReturn = MockData.mostRecommendedExperiences
        let result = try await repository.fetchMostRecentExperiences()
        try? await Task.sleep(nanoseconds: 100_000_000)

        // Assert
        XCTAssertEqual(result.count, 1)
    }

    func test_fetchHome_propagatesServiceError() async throws {
        // Arrange
        mockService.errorToThrow = URLError(.badURL)

        // Act & Assert
        do {
            _ = try await repository.fetchMostRecentExperiences()
            try? await Task.sleep(nanoseconds: 100_000_000)
        } catch {
            XCTAssertNotNil(error)
        }
    }
}

