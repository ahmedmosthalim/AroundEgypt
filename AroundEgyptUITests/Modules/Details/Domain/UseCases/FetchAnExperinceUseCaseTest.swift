//
//  FetchAnExperinceUseCaseTest.swift
//  AroundEgyptUITests
//
//  Created by Ahmed Mostafa on 31/08/2025.
//

import Foundation
import Combine
@testable import AroundEgypt
import XCTest


final class FetchAnExperinceUseCaseTest: XCTestCase {

    private var mockRepo: MockDetailsRepo!
    private var useCase: FetchAnExperinceUseCase!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockRepo = MockDetailsRepo()
        useCase = FetchAnExperinceUseCase(repository: mockRepo)
    }

    override func tearDownWithError() throws {
        mockRepo = nil
        useCase = nil
        try super.tearDownWithError()
    }

    func test_FetchAnExperince_success() async throws {
        mockRepo.dataToReturn = MockData.experience
        let result = try await useCase.excute(id: "123")
        XCTAssertEqual(result.id, "123")
    }

    func test_FetchAnExperince__failure() async {
        mockRepo.errorToThrow = URLError(.notConnectedToInternet)
        do {
            _ = try await useCase.excute(id: "123")
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }
}

