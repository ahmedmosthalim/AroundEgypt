//
//  MockGetLikedExperiencesUseCase.swift
//  AroundEgyptUITests
//
//  Created by Ahmed Mostafa on 31/08/2025.
//

import Foundation
@testable import AroundEgypt

final class MockGetLikedExperiencesUseCase : GetLikedExperiencesUseCaseContract {
    var dataToReturn: [String : Bool]?
    var errorToThrow: Error?

    func excute() -> [String : Bool] {
        if errorToThrow != nil {
            return [:]
        } else {
            return dataToReturn ?? [:]
        }
    }
}

final class MockSaveLikedExperiencesUseCase: SaveLikedExperiencesUseCaseContract {
    var dataToReturn: [String : Bool]?
    var errorToThrow: Error?
    func excute(list: [String : Bool]) {
    }
}
