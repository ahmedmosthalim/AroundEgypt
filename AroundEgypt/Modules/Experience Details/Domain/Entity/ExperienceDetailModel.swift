//
//  ExperienceDetailModel.swift
//  Around Egypt
//
//  
//

import Foundation


struct ExperienceDetail: Decodable {
    var id: String
    var title: String
    var coverPhoto: String
    var description: String
    var viewsNo: Int
    var likesNo: Int
    var recommended: Int
    var tourHtml: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, description
        case coverPhoto = "cover_photo"
        case viewsNo = "views_no"
        case likesNo = "likes_no"
        case recommended
        case tourHtml = "tour_html"
    }
}
extension ExperienceDetail {
    func isLiked(in likedExperiences: [String: Bool]) -> Bool {
        return likedExperiences[id] ?? false
    }
}

struct ExperienceDetailResponse: Decodable {
    var meta: Meta
    var data: ExperienceDetail
    var pagination: [String: String]?
}


