//
//  LocationDetailRequest.swift
//  Data_Network
//
//  Created by Marcelo Antunes on 5/27/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation

public struct LocationDetailRequest {
    let locationId: QueryProperty<String>
    let prox: QueryProperty<(position: PositionDto, radius: Int?)>

    public init(locationId: String,
                prox: (PositionDto, radius: Int?)) {
        self.locationId = QueryProperty(key: "locationid", value: locationId)
        self.prox = QueryProperty(key:"prox", value: prox)
    }

    var queryDict: [String: Any] {
        var dict = AuthorizationParam.dict
        dict["gen"] = Configuration.geocoderApiVersion
        dict[locationId.key] = locationId.value

        if let proxValue = prox.value {
            var proxString = "\(proxValue.position.latitude),\(proxValue.position.longitude)"
            if let radius = proxValue.radius {
                proxString += ",\(radius)"
            }
            dict[prox.key] = proxString
        }
        return dict
    }
}
