//
//  MockFetchAnExperinceUseCase.swift
//  AroundEgyptUITests
//
//  Created by Ahmed Mostafa on 31/08/2025.
//

import Foundation
@testable import AroundEgypt

final class MockFetchAnExperinceUseCase : FetchAnExperinceUseCaseContract {
    var dataToReturn: ExperienceDetail?
    var errorToThrow: Error?

    func excute(id: String) async throws -> ExperienceDetail {
        if let error = errorToThrow {
            throw error
        } else {
            return dataToReturn!
        }
    }
}
