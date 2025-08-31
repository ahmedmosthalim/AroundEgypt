//
//  HomeNetworkRequest.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 29/08/2025.
//

import Foundation
import NetworkLayer

struct HomeNetworkRequest: NetworkRequest {
    var type: HomeNetworkRequestType
    var host: String = NetworkConstants.baseHomeHost
    var path: String  {
        switch type {
        case .recent:
            NetworkConstants.Path.recentExperiences
        case .recommended:
            NetworkConstants.Path.recommendedExperiences
        case .search(_):
            NetworkConstants.Path.searchPath
        }
        
    }
    var method: NetworkLayer.HTTPMethod = .get

    var queryParameters: [String: String]? {
        switch type {
        case .search(let title):
            [NetworkConstants.QueryKey.filter: "\(title)"]
        case .recommended:
            [NetworkConstants.QueryKey.filter: "[recommended]=true"]
        default:
            nil
        }
    }
}

enum HomeNetworkRequestType {
    case recent
    case recommended
    case search(title: String)
}
