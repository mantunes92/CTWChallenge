//
//  RepositoryProviderImpl.swift
//  Data
//
//  Created by Marcelo Antunes on 5/23/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation
import Domain
import Data_Network
import Data_Realm
import RxSwift

public struct RepositoryProviderImpl {

    let networkProvider: NetworkProvider

    public init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }

    public init() {
        self.networkProvider = Network()
    }
}

extension RepositoryProviderImpl: Domain.RepositoryProvider {
    public func makeLocationRepository() -> LocationRepository {
        return LocationRepositoryImpl(networkProvider: networkProvider)
    }
    
    public func makeLocationDetailRepository() -> LocationDetailRepository {
        return LocationDetailRepositoryImpl()
    }
    
}
