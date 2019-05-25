//
//  QueryProperty.swift
//  Data_Network
//
//  Created by Marcelo Antunes on 5/25/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation

struct QueryProperty<T> {
    let key: String
    let value: T?

    init(key: String, value: T? = nil) {
        self.value = value
        self.key = key
    }
}
