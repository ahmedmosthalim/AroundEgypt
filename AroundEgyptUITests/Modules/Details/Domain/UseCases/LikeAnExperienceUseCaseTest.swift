//
//  LikeAnExperienceUseCaseTest.swift
//  AroundEgyptUITests
//
//  Created by Ahmed Mostafa on 31/08/2025.
//

import Foundation
import Combine
@testable import AroundEgypt
import XCTest


final class LikeAnExperienceUseCaseTest: XCTestCase {

    private var mockRepo: MockDetailsRepo!
    private var useCase: LikeAnExperienceUseCase!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockRepo = MockDetailsRepo()
        useCase = LikeAnExperienceUseCase(repository: mockRepo)
    }

    override func tearDownWithError() throws {
        mockRepo = nil
        useCase = nil
        try super.tearDownWithError()
    }

    func test_LikeAnExperience_success() async throws {
        // Act
        mockRepo.numberOfLikes = 12
        let result = try await useCase.excute(id: "123")

        // Assert
        XCTAssertEqual(result, 12)
    }

    func test_LikeAnExperience_failure() async {
        // Arrange
        mockRepo.errorToThrow = URLError(.notConnectedToInternet)

        // Act & Assert
        do {
            _ = try await useCase.excute(id: "123")
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }
}
