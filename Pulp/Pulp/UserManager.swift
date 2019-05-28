//
//  UserManager.swift
//  pulp_swift
//
//  Created by Jon Chon on 5/20/19.
//  Copyright © 2019 Jon Chon. All rights reserved.
//
import Foundation
import Moya
class UserManager {
    static let provider = MoyaProvider<VMAPI>.init(stubClosure: MoyaProvider<VMAPI>.immediatelyStub)
}

