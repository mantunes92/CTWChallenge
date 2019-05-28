//
//  LocationDetailVC.swift
//  CTWChallenge
//
//  Created by Marcelo Antunes on 5/28/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import UIKit
import Domain
import MapKit
import RxSwift

protocol LocationDetailNavigationDelegate: class {
    // Definition of navigation methods
    func goBack()
}

class LocationDetailVC: BaseViewController {

    @IBOutlet var mapView: MKMapView!

    @IBOutlet var streetPlaceholderLabel: UILabel!
    @IBOutlet var streetLabel: UILabel!
    @IBOutlet var postalCodePlaceholderLabel: UILabel!
    @IBOutlet var postalCodeLabel: UILabel!
    @IBOutlet var coordinatesPlaceholderLabel: UILabel!
    @IBOutlet var coordinatesLabel: UILabel!
    @IBOutlet var distancePlaceholderLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!

    @IBOutlet var actionButton: UIButton!

    //This viewModel is injected by LocationDetailCoordinator
    var viewModel: LocationDetailVM!
    weak var navigationDelegate: LocationDetailNavigationDelegate?

    private let regionRadius: CLLocationDistance = 1000

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialSetup()
        bindViewModel()
    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent || isBeingDismissed {
            navigationDelegate?.goBack()
        }
    }

    private func initialSetup() {
        navigationItem.title = viewModel.navBarTitle
        streetPlaceholderLabel.text = viewModel.streetPlaceholder
        postalCodePlaceholderLabel.text = viewModel.postalCodePlaceholder
        coordinatesPlaceholderLabel.text = viewModel.coordinatesPlaceholder
        distancePlaceholderLabel.text = viewModel.distancePlaceholder
    }

    private func bindViewModel() {
        assert(viewModel != nil, "viewModel cannot be nil")
        let input = LocationDetailVM.Input()

        let output = viewModel.transform(input: input)


        output.result
            .drive(onNext: setupView)
            .disposed(by: disposeBag)

        output.error
            .drive(onNext: presentError)
            .disposed(by: disposeBag)

        output.isLoading
            .drive(onNext: showLoading)
            .disposed(by: disposeBag)
    }

    private func setupView(_ detail: AddressDetail) {
        handleMap(detail.coordinates)
        streetLabel.text = detail.street
        postalCodeLabel.text = detail.postalCode
        coordinatesLabel.text = detail.coordinates.prettyDescription
        distanceLabel.text = "location.detail.distance.value".localizedWithFormat(arguments: detail.distance)
    }

    private func handleMap(_ coord: Position) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: coord.latitude,
                                                       longitude: coord.longitude)
        mapView.addAnnotation(annotation)
        let initialLocation = CLLocation(latitude: coord.latitude,
                                         longitude: coord.longitude)
        centerMapOnLocation(location: initialLocation)
    }
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

