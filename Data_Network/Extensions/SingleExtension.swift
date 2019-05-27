//
//  SingleExtension.swift
//  Data_Network
//
//  Created by Marcelo Antunes on 5/27/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation
import RxSwift
import Moya

extension PrimitiveSequence where TraitType == SingleTrait {

    func handleErrorIfNeeded() -> Single<ElementType> {
        return catchError({ error -> Single<ElementType> in
            guard let moyaError = error as? MoyaError else { throw NetworkError.error(error) }
            switch moyaError {
            case .statusCode(let response):
                if let errorDto = try? response.map(ErrorDto.self) {
                    throw NetworkError.serverError(errorDto)
                }
                throw NetworkError.withMessage("Invalid status code")
            default:
                throw NetworkError.error(error)
            }
        })
    }

}
