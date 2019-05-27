//
//  Network.swift
//  Data_Network
//
//  Created by Marcelo Antunes on 5/23/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation
import Moya

public struct Network {

    let provider: MoyaProvider<MultiTarget>

    public init() {
        #if DEBUG
        provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])
        #else
        provider = MoyaProvider<MultiTarget>()
        #endif
    }

}
