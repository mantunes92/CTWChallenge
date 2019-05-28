//
//  LocationManager.swift
//  CTWChallenge
//
//  Created by Marcelo Antunes on 5/28/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa
import CoreLocation
import RxCoreLocation

final class LocationManager {

    static let shared = LocationManager()

    private let locationManager: CLLocationManager
    private init() {
        locationManager = CLLocationManager()
        defaultHandlingOfAuthorizationStatusChange()
    }

    private var disposeBag = DisposeBag()
    private func defaultHandlingOfAuthorizationStatusChange() {
        disposeBag = DisposeBag()
        locationManager.rx.didChangeAuthorization
            .subscribe(onNext: { [weak self] (_, status: CLAuthorizationStatus) in
                switch status {
                case .restricted, .denied:
                    // Disable location features
                    self?.disableLocationBasedFeatures()
                case .authorizedWhenInUse:
                    // Enable location features
                    self?.enableWhenInUseFeatures()
                case .authorizedAlways:
                    // Enable location features
                    self?.enableAlwaysInUseFeatures()
                case .notDetermined:
                    break
                @unknown default:
                    return
                }
            })
            .disposed(by: disposeBag)
    }

    private func disableLocationBasedFeatures() {}
    private func enableWhenInUseFeatures() {}
    private func enableAlwaysInUseFeatures() {}

    func requestAuthorization(always: Bool = false) {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            if always {
                // Request always authorization
                locationManager.requestAlwaysAuthorization()
            } else {
                // Request when-in-use authorization initially
                locationManager.requestWhenInUseAuthorization()
            }
        default:
            return
        }
    }

    func currentLocation() -> Single<CLLocation?> {
        return locationManager.rx.location
            .first()
            .map({ location -> CLLocation? in
                guard let loc = location else { throw CtwError.unexpectedNil }
                return loc
            })
    }
}
