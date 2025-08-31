//
//  MockData.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 31/08/2025.
//

import Foundation
@testable import AroundEgypt


enum MockData {
    static let mostRecentExperiences: ExperiencesResponse  = ExperiencesResponse(
        meta: Meta(
            code: 200,
            errors: []
        ), data: [
            Experience(id: "fisrt", title: "", coverPhoto: "", description: "", viewsNo: 100, likesNo: 100, recommended: 1, hasVideo: 0),
            Experience(id: "second", title: "", coverPhoto: "", description: "", viewsNo: 100, likesNo: 100, recommended: 1, hasVideo: 0)
        ]
    )
    
    static let experiences: [Experience]  = [
        Experience(id: "fisrt", title: "", coverPhoto: "", description: "", viewsNo: 100, likesNo: 100, recommended: 1, hasVideo: 0),
        Experience(id: "second", title: "", coverPhoto: "", description: "", viewsNo: 100, likesNo: 100, recommended: 1, hasVideo: 0)
    ]
    
    
    static let likedExperiences: [String:Bool]  = [
        "fisrt": true
    ]
    
    
    
    static let mostRecommendedExperiences: ExperiencesResponse  = ExperiencesResponse(
        meta: Meta(
            code: 200,
            errors: []
        ), data: [
            Experience(id: "fisrtRecomend", title: "", coverPhoto: "", description: "", viewsNo: 100, likesNo: 100, recommended: 1, hasVideo: 0),
        ]
    )
    
    static let emptyArray: ExperiencesResponse  = ExperiencesResponse(
        meta: Meta(
            code: 200,
            errors: []
        ), data: []
    )
    
    static let experienceResponse: ExperienceDetailResponse  = ExperienceDetailResponse(
        meta: Meta(
            code: 200,
            errors: []
        ), data: ExperienceDetail(
            id: "123",
            title: "test",
            coverPhoto: "",
            description: "",
            viewsNo: 1,
            likesNo: 1,
            recommended: 1,
            tourHtml: ""
        )
    )
    
    static let experience: ExperienceDetail  = ExperienceDetail(
        id: "123",
        title: "test",
        coverPhoto: "",
        description: "",
        viewsNo: 1,
        likesNo: 1,
        recommended: 1,
        tourHtml: ""
    )
    
    static let likeResponse: LikeResponse  = LikeResponse(
        meta: Meta(
            code: 200,
            errors: []
        ),
        data: 12,
        pagination: [:]
    )
    
    static let error = NSError(domain: "TestError", code: 999, userInfo: [NSLocalizedDescriptionKey: "Mock network error"])
}
