//
//  LikeResponse.swift
//  Around Egypt
//
//  
//

import Foundation

struct LikeResponse: Decodable {
    let meta: Meta
    let data: Int
    let pagination: [String: String]?
}

