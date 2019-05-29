//
//  AddressDetailDto.swift
//  Data_Network
//
//  Created by Marcelo Antunes on 5/24/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation

public struct AddressDetailDto: Codable {
    public let label: String
    public let country: String?
    public let state: String?
    public let county: String?
    public let city: String?
    public let district: String?
    public let street: String?
    public let houseNumber: String?
    public let postalCode: String?
    public let additionalData: [AdditionalDataDto]?

    enum CodingKeys: String, CodingKey {
        case label = "Label"
        case country = "Country"
        case state = "State"
        case county = "County"
        case city = "City"
        case district = "District"
        case street = "Street"
        case houseNumber = "HouseNumber"
        case postalCode = "PostalCode"
        case additionalData = "AdditionalData"
    }

    public init(label: String,
                country: String?,
                state: String?,
                county: String?,
                city: String?,
                district: String?,
                street: String?,
                houseNumber: String?,
                postalCode: String?,
                additionalData: [AdditionalDataDto]?) {
        self.label = label
        self.country = country
        self.state = state
        self.county = county
        self.city = city
        self.district = district
        self.street = street
        self.houseNumber = houseNumber
        self.postalCode = postalCode
        self.additionalData = additionalData
    }
}
