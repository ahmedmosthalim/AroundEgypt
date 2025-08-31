//
//  ExperienceDetailsRepositoryTest.swift
//  AroundEgyptUITests
//
//  Created by Ahmed Mostafa on 31/08/2025.
//

import XCTest
import Combine
@testable import AroundEgypt

final class ExperienceDetailsRepositoryTest: XCTestCase {
    
    private var mockService: MockDetailsService!
    private var repository: ExperienceDetailsRepository!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockService = MockDetailsService()
        repository = ExperienceDetailsRepository(service: mockService)
    }
    
    override func tearDownWithError() throws {
        mockService = nil
        repository = nil
        try super.tearDownWithError()
    }
    
    func test__success_fetchAnExperience() async throws {
        // Act
        mockService.fetchAnExperienceData = MockData.experienceResponse
        let result = try await repository.fetchExperienceByID(id: "123")
        
        // Assert
        XCTAssertEqual(result.id, "123")
    }
    
    func test_failure_fetchAnExperience() async throws {
        // Arrange
        mockService.errorToThrow = URLError(.badURL)
        
        // Act & Assert
        do {
            _ = try await repository.fetchExperienceByID(id: "123")
            XCTFail("Expected fetchHome to throw, but it succeeded.")
        } catch {
            XCTAssertNotNil(error)
        }
    }    
    func test__success_LikeAnExperience() async throws {
        // Act
        mockService.likeAnExperienceData = MockData.likeResponse
        let result = try await repository.likeExperience(id: "123")
        
        // Assert
        XCTAssertEqual(result, 12)
    }
    
    func test_failure_LikeAnExperience() async throws {
        // Arrange
        mockService.errorToThrow = URLError(.badURL)
        
        // Act & Assert
        do {
            _ = try await repository.likeExperience(id: "123")
            XCTFail("Expected fetchHome to throw, but it succeeded.")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }
}

