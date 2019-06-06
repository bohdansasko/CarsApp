//
//  CACarsAPI.swift
//  CarsApp
//
//  Created by Bogdan Sasko on 6/4/19.
//  Copyright © 2019 Vinso. All rights reserved.
//

import Moya

enum CACarsAPI {
    case carsList
}

extension CACarsAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "http://www.codetalk.de") else {
            fatalError("coudn't configure url")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .carsList: return "/cars.json"
        }
    }
    
    var method: Method {
        switch self {
        case .carsList: return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .carsList: return "Nothing better than double nothing :)".data(using: .utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .carsList: return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
