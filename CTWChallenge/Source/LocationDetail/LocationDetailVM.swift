//
//  LocationDetailVM.swift
//  CTWChallenge
//
//  Created by Marcelo Antunes on 5/28/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

final class LocationDetailVM {

    let navBarTitle: String = "location.detail.nav.bar.item.title".localized
    let streetPlaceholder: String = "location.detail.street.placeholder".localized
    let postalCodePlaceholder: String = "location.detail.postal.code.placeholder".localized
    let coordinatesPlaceholder: String = "location.detail.coordinates.placeholder".localized
    let distancePlaceholder: String = "location.detail.distance.placeholder".localized
    let saveFavoriteLocation: String = "location.detail.save.favorite.btn.title".localized
    let removeFavoriteLocation: String = "location.detail.remove.favorite.btn.title".localized

    private let repo: Domain.LocationRepository
    private let locationId: String

    init(repo: Domain.LocationRepository, locationId: String) {
        self.repo = repo
        self.locationId = locationId
    }
}

extension LocationDetailVM: ViewModelType {
    struct Input {
        let saveTrigger: Driver<Void>
        let removeTrigger: Driver<Void>
    }

    struct Output {
        let result: Driver<Location>
        let save: Driver<Void>
        let remove: Driver<Void>
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

        let result = location
            .asObservable()
            .flatMap { [weak self] position -> Observable<Location> in
                guard let self = self else { throw CtwError.unexpectedNil }
                return self.repo.getLocationDetail(id: self.locationId,
                                                   position: position)
            }
            .trackActivity(activityTracker)
            .trackError(errorTracker)
            .asDriverOnErrorJustComplete()

        let save = input.saveTrigger.withLatestFrom(result)
            .debounce(1)
            .flatMapLatest({ [weak self] addressDetail -> Driver<Void> in
                guard let self = self else { return Driver.empty() }
                return self.repo.saveLocation(location: addressDetail)
                    .trackActivity(activityTracker)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
                    .map { _ -> Void in
                        return ()
                }
            })

        let remove = input.removeTrigger.withLatestFrom(result)
            .debounce(1)
            .flatMapLatest({ [weak self] addressDetail -> Driver<Void> in
                guard let self = self else { return Driver.empty() }
                return self.repo.deleteLocation(location: addressDetail)
                    .trackActivity(activityTracker)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
                    .map { _ -> Void in
                        return ()
                }
            })

        let error = errorTracker.asDriver()
        let isLoading = activityTracker.asDriver()

        return Output(result: result,
                      save: save,
                      remove: remove,
                      error: error,
                      isLoading: isLoading)
    }
}
