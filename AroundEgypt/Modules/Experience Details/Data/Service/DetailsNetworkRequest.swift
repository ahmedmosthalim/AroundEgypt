//
//  DetailsNetworkRequest.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 29/08/2025.
//

import Foundation
import NetworkLayer

struct DetailsNetworkRequest: NetworkRequest {
    var type: DetailsNetworkRequestType
    var host: String = NetworkConstants.baseHomeHost
    var path: String  {
        switch type {
        case .fetchAnExperience(let id):
            "\(NetworkConstants.Path.fetchAnExperience)/\(id)"
        case .likeAnExperience(let id):
            "\(NetworkConstants.Path.likeExperience)/\(id)/like"
        }
        
    }
    var method: NetworkLayer.HTTPMethod  {
        switch type {
        case .fetchAnExperience(_):
                .get
        case .likeAnExperience(_):
                .post
        }
    }

    var queryParameters: [String: String]? {
        return nil
    }
}

enum DetailsNetworkRequestType {
    case fetchAnExperience(id: String)
    case likeAnExperience(id: String)
}
