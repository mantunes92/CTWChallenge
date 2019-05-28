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
    let dataBaseProvider: DataBaseProvider

    public init(networkProvider: NetworkProvider, dataBaseProvider: DataBaseProvider) {
        self.networkProvider = networkProvider
        self.dataBaseProvider = dataBaseProvider
    }

    public init() {
        self.networkProvider = Network()
        self.dataBaseProvider = DataBase()
    }
}

extension RepositoryProviderImpl: Domain.RepositoryProvider {
    public func makeSuggestionsRepository() -> SuggestionsRepository {
        return SuggestionsRepositoryImpl(networkProvider: networkProvider)
    }
    
    public func makeLocationRepository() -> LocationRepository {
        return LocationRepositoryImpl(networkProvider: networkProvider,
                                      dataBaseProvider: dataBaseProvider)
    }
    
}
