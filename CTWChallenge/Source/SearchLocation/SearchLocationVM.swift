//
//  SearchLocationVM.swift
//  CTWChallenge
//
//  Created by Marcelo Antunes on 5/22/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa
import Differentiator

final class SearchLocationVM {

    private let repo: Domain.SuggestionsRepository

    init(repo: Domain.SuggestionsRepository) {
        self.repo = repo
    }
}

extension SearchLocationVM: ViewModelType {
    struct Input {
        let textFilter: Driver<String?>
    }

    struct Output {
        let tableItems: Driver<[Domain.Suggestion]>
        let error: Driver<Error>
        let isLoading: Driver<Bool>
    }

    func transform(input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker()
        let tableItems = input.textFilter
            .debounce(0.5)
            .flatMapLatest({ [weak self] searchText -> Driver<[Domain.Suggestion]> in
                guard let self = self else { return Driver.empty() }
                let text = searchText ?? ""
                return self.repo.getLocations(named: text,
                                              position: Position(latitude: 2, longitude: 2))
                    .trackActivity(activityTracker)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            })

        let error = errorTracker.asDriver()
        let isLoading = activityTracker.asDriver()

        return Output(tableItems: tableItems,
                      error: error,
                      isLoading: isLoading)
    }
}


extension Domain.Suggestion: IdentifiableType {
    public typealias Identity = String
    public var identity: String {
        return locationId
    }
}
