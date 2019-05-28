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

    private let repo: Domain.LocationDetailRepository
    private let locationId: String

    init(repo: Domain.LocationDetailRepository, locationId: String) {
        self.repo = repo
        self.locationId = locationId
    }
}

extension LocationDetailVM: ViewModelType {
    struct Input {}

    struct Output {
        let result: Driver<AddressDetail>
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
            .flatMap { [weak self] position -> Single<AddressDetail> in
                guard let self = self else { throw CtwError.unexpectedNil }
                return self.repo.getLocationDetail(id: self.locationId,
                                                   position: position)
            }
            .trackActivity(activityTracker)
            .trackError(errorTracker)
            .asDriverOnErrorJustComplete()

        let error = errorTracker.asDriver()
        let isLoading = activityTracker.asDriver()

        return Output(result: result,
                      error: error,
                      isLoading: isLoading)
    }
}
