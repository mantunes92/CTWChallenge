//
//  MatchLevelDto.swift
//  Data_Network
//
//  Created by Marcelo Antunes on 5/26/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation

public enum MatchLevelDto: String, Codable {
    case houseNumber = "houseNumber"
    case intersection = "intersection"
    case street = "street"
    case postalCode = "postalCode"
    case district = "district"
    case city = "city"
    case county = "county"
    case state = "state"
    case country = "country"
}
