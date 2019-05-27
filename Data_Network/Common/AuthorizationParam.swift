//
//  AuthorizationParam.swift
//  Data_Network
//
//  Created by Marcelo Antunes on 5/25/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation

struct AuthorizationParam {
    static let appId = Configuration.appId
    static let appCode = Configuration.appCode

    static let dict: [String: Any] = ["app_id": AuthorizationParam.appId, "app_code": AuthorizationParam.appCode]
    private init() {}
}
