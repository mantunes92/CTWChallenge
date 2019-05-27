//
//  Configuration.swift
//  Data_Network
//
//  Created by Marcelo Antunes on 5/25/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation

struct Configuration {
    static func property(withName name: String) -> String {
        let bundle = Bundle(identifier: "pt.ctw.app.Data-Network")
        return (bundle?.infoDictionary?[name] as? String)!
    }
}

//MARK: - Properties from config file
extension Configuration {
    static var appId: String {
        return property(withName: "APP_ID")
    }

    static var appCode: String {
        return property(withName: "APP_CODE")
    }

    static var geocoderAutocompleteBasePath: String {
        return property(withName: "GEOCODER_AUTOCOMPLETE_BASE_URL")
    }

    static var geocoderAutocompleteSuggestionsPath: String {
        return property(withName: "GEOCODER_AUTOCOMPLETE_SUGGESTIONS_PATH")
    }

    static var geocoderBasePath: String {
        return property(withName: "GEOCODER_BASE_URL")
    }

    static var geocoderGeocodingPath: String {
        return property(withName: "GEOCODER_PATH")
    }

    static var geocoderApiVersion: String {
        return property(withName: "GEOCODER_API_VERSION")
    }
}
