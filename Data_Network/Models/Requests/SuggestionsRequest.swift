//
//  SuggestionsRequest.swift
//  Data_Network
//
//  Created by Marcelo Antunes on 5/24/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation

public struct SuggestionsRequest {
    /**
     The search text which is the basis of the query.
     */
    let query: QueryProperty<String>

    /**
     The upper limit the for number of suggestions to be included in the response. Default is set to 5.

     Valid range: 1 to 20.
     */
    let maxResults: QueryProperty<Int>

    /**
     A type of Spatial Filter. The spatial filter limits the search for any other attributes in the request. The country parameter limits suggestions to a country or set of countries.

     country=ISO3 country code

     Can be combined with the mapview or prox spatial filters.
     */
    let country: QueryProperty<[String]>

    /**
     A type of Spatial Filter. Sets a focus on a geographic area represented by the top-left and the bottom-right corners of a bounding box so the results within this area are more important than results outside of this area. 
     */
    let mapview: QueryProperty<MapViewDto>

    /**
     A type of Spatial Filter. Sets a focus on a geographic area represented by a single geo-coordinate pair and optionally a radius (in meters) so the results within this area are more important than results outside of this area.
     */
    let prox: QueryProperty<(position: PositionDto?, radius: Int?)>

    /**
     Mark the beginning of the match in a token. This can be any character sequence. Common usage is a HTML tag such as <b> for bold. But it can also be a square bracket, "[".

     Default: no marker
     */
    let beginHighlight: QueryProperty<String>

    /**
     Mark the end of the match in a token.
     */
    let endHighlight: QueryProperty<String>

    /**
     The preferred language of address elements in the result.

     The language parameter must be provided as 2-letter ISO language code. The plural form of the parameter (languages) is not supported and ignored. Only one language can be provided. The language setting changes the language of result elements where available in the map data. The language setting has no impact on matching or ranking and it does not express any regional preference.

     The default response language is the language that is most relevant to the query.
     */
    let language: QueryProperty<String>


    /**
     The resultType=areas mode will filter results to return areas. Results with matchLevels of houseNumber , postalCode, street and intersection will not be returned.
     */
    let resulTypeValue: QueryProperty<String>

    public init(query: String,
                maxResults: Int? = nil,
                country: [String]? = nil,
                mapview: MapViewDto? = nil,
                prox: (PositionDto?, radius: Int?)? = nil,
                beginHighlight: String? = nil,
                endHighlight: String? = nil,
                language: String? = nil,
                resulTypeValue: Bool = false) {
        self.query = QueryProperty(key: "query", value: query)
        self.maxResults = QueryProperty(key: "maxResults", value: maxResults)
        self.country = QueryProperty(key:"country", value: country)
        self.mapview = QueryProperty(key:"mapview", value: mapview)
        self.prox = QueryProperty(key:"prox", value: prox)
        self.beginHighlight = QueryProperty(key:"beginHighlight", value: beginHighlight)
        self.endHighlight = QueryProperty(key:"endHighlight", value: endHighlight)
        self.language = QueryProperty(key:"language", value: language)
        self.resulTypeValue = QueryProperty(key:"resulTypeValue", value: resulTypeValue ? "areas" : nil)
    }

    var asDictionary: [String: Any] {
        var dict = AuthorizationParam.dict
        dict[query.key] = query.value

        if let maxResultsValue = maxResults.value {
            dict[maxResults.key] = maxResultsValue
        }
        if let countryValue = country.value {
            let countriesString = countryValue.reduce("") { result, country -> String in
                if result.isEmpty {
                    return country
                }
                return result + ",\(country)"
            }
            dict[country.key] = countriesString
        }
        if let mapviewValue = mapview.value {
            let mapviewString = "\(mapviewValue.topLeft.latitude),\(mapviewValue.topLeft.longitude);\(mapviewValue.bottomRight.latitude),\(mapviewValue.bottomRight.longitude)"
            dict[mapview.key] = mapviewString
        }
        if let proxValue = prox.value {
            if let position = proxValue.position {
                var proxString = "\(position.latitude),\(position.longitude)"
                if let radius = proxValue.radius {
                    proxString += ",\(radius)"
                }
                dict[prox.key] = proxString
            }
        }
        if let beginHighlightValue = beginHighlight.value {
            dict[beginHighlight.key] = beginHighlightValue
        }
        if let endHighlightValue = endHighlight.value {
            dict[endHighlight.key] = endHighlightValue
        }
        if let languageValue = language.value {
            dict[language.key] = languageValue
        }
        if let resulTypeValueValue = resulTypeValue.value {
            dict[resulTypeValue.key] = resulTypeValueValue
        }
        return dict
    }
}

//public enum Areas: String, Codable {
//    case houseNumber
//    case intersection
//    case street
//    case postalCode
//    case district
//    case city
//    case county
//    case state
//    case country
//}
