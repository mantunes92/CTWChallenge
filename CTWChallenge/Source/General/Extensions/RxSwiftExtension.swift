//
//  ObservableTypeExtension.swift
//  CTWChallenge
//
//  Created by Marcelo Antunes on 5/27/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension PrimitiveSequence {
    func asDriverOnErrorJustComplete() -> Driver<ElementType> {
        return asDriver(onErrorRecover: { error -> Driver<ElementType> in
            return Driver.empty()
        })
    }
}

extension ObservableType {
    func asDriverOnErrorJustComplete() -> Driver<E> {
        return asDriver(onErrorRecover: { error -> Driver<E> in
            return Driver.empty()
        })
    }
}
