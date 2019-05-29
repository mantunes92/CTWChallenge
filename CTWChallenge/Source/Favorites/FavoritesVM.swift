//
//  FavoritesVM.swift
//  CTWChallenge
//
//  Created by Marcelo Antunes on 5/29/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa
import Differentiator

final class FavoritesVM {

    let navBarTitle: String = "favorites.nav.bar.item.title".localized
    let navBarDismissBtnTitle: String = "favorites.nav.bar.dismiss.btn.title".localized

    private let repo: Domain.LocationRepository

    init(repo: Domain.LocationRepository) {
        self.repo = repo
    }
}

extension FavoritesVM: ViewModelType {
    struct Input {}

    struct Output {
        let result: Driver<[Location]>
    }

    func transform(input: Input) -> Output {
        let result = repo.getFavorites()
            .asDriverOnErrorJustComplete()
        return Output(result: result)
    }
}


extension Location: IdentifiableType {
    public typealias Identity = String
    public var identity: String {
        return locationId
    }
}
