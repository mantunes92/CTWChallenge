//
//  FavoritesVC.swift
//  CTWChallenge
//
//  Created by Marcelo Antunes on 5/29/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import UIKit
import Domain
import MapKit
import RxSwift
import RxDataSources
import RxCocoa

protocol FavoritesNavigationDelegate: class {
    // Definition of navigation methods
    func goBack()
}

class FavoritesVC: BaseViewController {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var tableView: UITableView!
    
    //This viewModel is injected by LocationDetailCoordinator
    var viewModel: FavoritesVM!
    weak var navigationDelegate: FavoritesNavigationDelegate?

    private let regionRadius: CLLocationDistance = 1000

    typealias Section = AnimatableSectionModel<String, Location>

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialSetup()
        bindViewModel()
    }

    private func initialSetup() {
        navigationItem.title = viewModel.navBarTitle
        addDismissButton()
        setupTableView()
    }

    private func addDismissButton() {
        let dismissBtn = UIBarButtonItem(title: viewModel.navBarDismissBtnTitle,
                                         style: .plain,
                                         target: self,
                                         action: #selector(dismissTouched))

        navigationItem.setRightBarButton(dismissBtn, animated: true)
    }

    @objc private func dismissTouched() {
        dismiss(animated: true, completion: { [weak self] in
            self?.navigationDelegate?.goBack()
        })
    }

    private func setupTableView() {
        tableView.keyboardDismissMode = .interactive
        tableView.register(UINib(nibName: FavoriteTableViewCell.name, bundle: Bundle.main),
                           forCellReuseIdentifier: FavoriteTableViewCell.name)

        tableView.rx.modelSelected(Location.self)
            .subscribe(onNext: { [weak self] location in
                self?.addMarker(location.coordinates)
            })
            .disposed(by: disposeBag)
    }

    private func addMarker(_ coord: Position) {
        mapView.removeAnnotations(mapView.annotations)
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

    private func bindViewModel() {
        assert(viewModel != nil, "viewModel cannot be nil")
        let input = FavoritesVM.Input()

        let output = viewModel.transform(input: input)

        bindToTableView(output.result)
    }

    private func bindToTableView(_ tableItems: Driver<[Location]>) {
        let dataSource = RxTableViewSectionedAnimatedDataSource<Section>(configureCell: configureCell)

        tableItems
            .map { [Section(model: "Favorites", items: $0)] }
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

    }

    private func configureCell(dataSource: TableViewSectionedDataSource<Section>,
                               tableView: UITableView,
                               indexPath: IndexPath,
                               item: Location) -> UITableViewCell {
        weak var _self = self
        guard let self = _self else { return UITableViewCell() }

        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.name,
                                                 for: indexPath) as! FavoriteTableViewCell

        cell.textLabel?.text = item.label

        return cell
    }

}
