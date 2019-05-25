//
//  AddressDto.swift
//  Data_Network
//
//  Created by Marcelo Antunes on 5/23/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation

public struct AddressDto: Codable {
    public let country: String?
    public let state: String?
    public let county: String?
    public let city: String?
    public let district: String?
    public let postalCode: String?
    public let street: String?

    enum CodingKeys: String, CodingKey {
        case country = "country"
        case state = "state"
        case county = "county"
        case city = "city"
        case district = "district"
        case postalCode = "postalCode"
        case street = "street"
    }

    public init(country: String?,
                state: String?,
                county: String?,
                city: String?,
                district: String?,
                postalCode: String?,
                street: String?) {
        self.country = country
        self.state = state
        self.county = county
        self.city = city
        self.district = district
        self.postalCode = postalCode
        self.street = street
    }
}
