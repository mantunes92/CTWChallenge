//
//  SuggestionsResponse.swift
//  Data_Network
//
//  Created by Marcelo Antunes on 5/24/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation

public struct SuggestionsResponse: Codable {
    public let suggestions: [SuggestionDto]

    enum CodingKeys: String, CodingKey {
        case suggestions = "suggestions"
    }

    public init(suggestions: [SuggestionDto]) {
        self.suggestions = suggestions
    }
}
