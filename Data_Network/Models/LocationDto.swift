//
//  LocationDto.swift
//  Data_Network
//
//  Created by Marcelo Antunes on 5/24/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation

public struct LocationDto: Codable {
    public let locationId: String
    public let locationType: String
    public let displayPosition: PositionDto
    public let navigationPosition: [PositionDto]
    public let mapView: MapViewDto
    public let address: AddressDetailDto

    enum CodingKeys: String, CodingKey {
        case locationId = "LocationId"
        case locationType = "LocationType"
        case displayPosition = "DisplayPosition"
        case navigationPosition = "NavigationPosition"
        case mapView = "MapView"
        case address = "Address"
    }

    public init(locationId: String, locationType: String, displayPosition: PositionDto, navigationPosition: [PositionDto], mapView: MapViewDto, address: AddressDetailDto) {
        self.locationId = locationId
        self.locationType = locationType
        self.displayPosition = displayPosition
        self.navigationPosition = navigationPosition
        self.mapView = mapView
        self.address = address
    }
}
