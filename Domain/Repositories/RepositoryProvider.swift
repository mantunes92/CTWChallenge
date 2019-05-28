//
//  RepositoryProvider.swift
//  Domain
//
//  Created by Marcelo Antunes on 5/23/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation

public protocol RepositoryProvider {
    func makeSuggestionsRepository() -> SuggestionsRepository
    func makeLocationRepository() -> LocationRepository
}
