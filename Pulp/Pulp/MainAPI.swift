//
//  moya.swift
//  pulp_swift
//
//  Created by Jon Chon on 5/20/19.
//  Copyright © 2019 Jon Chon. All rights reserved.
//
import Foundation
import Moya

enum MainAPI {
    case fbLogin(accessToken: String)
}
extension MainAPI: TargetType {
    var BaseURL: URL {
        switch self {
        case .fbLogin:
            return URL(string: "https://localhost:3000")
        }
    }
    var path: String {
        switch self {
        case .fbLogin:
            return "/auth/facebook/token"
        }
    }
    var method: Moya.Method {
        switch self {
        case .fbLogin:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .fbLogin(let accessToken):
            return .requestParameters(parameters: ["accessToken" : accessToken], encoding: URLEncoding.default)
        }
    }
}
