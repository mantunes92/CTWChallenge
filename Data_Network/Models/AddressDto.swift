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
    public let street: String?
    public let houseNumber: String?
    public let unit: String?
    public let postalCode: String?

    enum CodingKeys: String, CodingKey {
        case country = "country"
        case state = "state"
        case county = "county"
        case city = "city"
        case district = "district"
        case street = "street"
        case houseNumber = "houseNumber"
        case unit = "unit"
        case postalCode = "postalCode"
    }

    public init(country: String?,
                state: String?,
                county: String?,
                city: String?,
                district: String?,
                street: String?,
                houseNumber: String?,
                unit: String?,
                postalCode: String?) {
        self.country = country
        self.state = state
        self.county = county
        self.city = city
        self.district = district
        self.street = street
        self.houseNumber = houseNumber
        self.unit = unit
        self.postalCode = postalCode
    }
}
