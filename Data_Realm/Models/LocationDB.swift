//
//  LocationDB.swift
//  Data_Realm
//
//  Created by Marcelo Antunes on 5/28/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation
import RealmSwift

public class LocationDB: Object {

    @objc public dynamic var locationId: String!
    @objc public dynamic var label: String!
    @objc public dynamic var street: String?
    @objc public dynamic var postalCode: String?
    @objc public dynamic var latitude: Double = 0.0
    @objc public dynamic var longitude: Double = 0.0
    @objc public dynamic var distance: Double = 0.0

    override public class func primaryKey() -> String? {
        return "locationId"
    }

    public convenience init(locationId: String,
                            label: String,
                            street: String?,
                            postalCode: String?,
                            latitude: Double,
                            longitude: Double,
                            distance: Double) {
        self.init()
        self.locationId = locationId
        self.label = label
        self.street = street
        self.postalCode = postalCode
        self.latitude = latitude
        self.longitude = longitude
        self.distance = distance
    }
}

