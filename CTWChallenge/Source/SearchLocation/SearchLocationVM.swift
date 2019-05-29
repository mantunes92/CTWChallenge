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

    let navBarTitle: String = "suggestions.nav.bar.item.title".localized
    let placeholder: String = "suggestions.search.placeholder".localized
    let sortBtnTitle: String = "suggestions.sort.btn.title".localized
    let favoritesBtnTitle: String = "suggestions.favorites.btn.title".localized
    let emptyListInfo: String = "suggestions.empty.list".localized

    private let currentSort = BehaviorSubject<SortType>(value: .distance)

    private let repo: Domain.SuggestionsRepository

    init(repo: Domain.SuggestionsRepository) {
        self.repo = repo
    }

    func changeSort(_ type: SortType) {
        currentSort.onNext(type)
    }
    func getCurrentSort() -> SortType {
        return (try? currentSort.value()) ?? .distance
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

        let location = LocationManager.shared.currentLocation()
            .map { cllocation -> Position in
                guard let loc = cllocation else { return Position.ctwHeadquarter }
                return Position(latitude: loc.coordinate.latitude,
                                longitude: loc.coordinate.longitude)
        }
        let tableItems = input.textFilter
            .distinctUntilChanged()
            .debounce(0.5)
            .flatMapLatest({ [weak self] searchText -> Driver<[Suggestion]> in
                guard let self = self else { return Driver.empty() }
                let text = searchText ?? ""
                return location
                    .flatMap({ position -> Single<[Suggestion]> in
                        return self.repo.getLocations(named: text,
                                                      position: position)
                    })
                    .trackActivity(activityTracker)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            })

        let sort = currentSort.asDriverOnErrorJustComplete()
        let orderedTableItems = Driver.combineLatest(tableItems, sort)
            .map { suggestions, sortType -> [Suggestion] in
                switch sortType {
                case .distance:
                    return suggestions.sorted(by: { $0.distance < $1.distance })
                case .name:
                    return suggestions.sorted(by: { $0.label < $1.label })
                }
        }

        let error = errorTracker.asDriver()
        let isLoading = activityTracker.asDriver()

        return Output(tableItems: orderedTableItems,
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
