//
//  FetchAnExperinceUseCaseContract.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 29/08/2025.
//

import Foundation

protocol FetchAnExperinceUseCaseContract {
    func excute(id:String) async throws -> ExperienceDetail
}
