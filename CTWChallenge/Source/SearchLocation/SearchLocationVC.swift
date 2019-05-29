//
//  SearchLocationVC.swift
//  CTWChallenge
//
//  Created by Marcelo Antunes on 5/21/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import UIKit
import Domain
import Data
import RxSwift
import RxCocoa
import RxDataSources

protocol SearchLocationNavigationDelegate: class {
    // Definition of navigation methods
    func didSelectLocation(_ locationId: String)
    func didPressFavorites()
}

class SearchLocationVC: BaseViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var emptyListLabel: UILabel!
    
    //This viewModel is injected by SearchLocationCoordinator
    var viewModel: SearchLocationVM!
    weak var navigationDelegate: SearchLocationNavigationDelegate?

    typealias Section = AnimatableSectionModel<String, Suggestion>

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialSetup()
        bindViewModel()
    }

    private func initialSetup() {
        navigationItem.title = viewModel.navBarTitle
        emptyListLabel.text = viewModel.emptyListInfo
        setupSearchBar()

        setupNavBarButtons()
        setupTableView()

        LocationManager.shared.requestAuthorization()
    }

    private func setupSearchBar() {
        searchBar.placeholder = viewModel.placeholder
        searchBar.showsCancelButton = true
        searchBar.rx.cancelButtonClicked
            .subscribe(onNext: { [weak self] in
                self?.searchBar.endEditing(true)
            })
        .disposed(by: disposeBag)
    }

    private func setupTableView() {
        tableView.keyboardDismissMode = .interactive
        tableView.register(UINib(nibName: SearchTableViewCell.name, bundle: Bundle.main),
                           forCellReuseIdentifier: SearchTableViewCell.name)

        tableView.rx.modelSelected(Suggestion.self)
            .subscribe(onNext: { [weak self] suggestion in
                self?.navigationDelegate?.didSelectLocation(suggestion.locationId)
            })
        .disposed(by: disposeBag)
    }

    private func setupNavBarButtons() {
        setupSortingFilterBtn()
        setupFavoritesBtn()
    }

    private func setupFavoritesBtn() {
        let barBtn = UIBarButtonItem(title: viewModel.favoritesBtnTitle,
                                     style: .plain,
                                     target: self,
                                     action: #selector(favoritesTouched))
        navigationItem.setRightBarButton(barBtn, animated: true)
    }
    @objc private func favoritesTouched() {
        navigationDelegate?.didPressFavorites()
    }

    private func setupSortingFilterBtn() {
        let barBtn = UIBarButtonItem(title: viewModel.sortBtnTitle,
                                     style: .plain,
                                     target: self,
                                     action: #selector(sortingTouched))

        navigationItem.setLeftBarButton(barBtn, animated: true)
    }
    @objc private func sortingTouched() {
        let popoverController = SortPopoverController()
        popoverController.initialSelection = viewModel.getCurrentSort()
        popoverController.delegate = self
        popoverController.modalPresentationStyle = .popover
        popoverController.preferredContentSize = CGSize(width: 150, height: 150)

        if let popoverPresentationController = popoverController.popoverPresentationController {
            popoverPresentationController.permittedArrowDirections = .up
            popoverPresentationController.barButtonItem = navigationItem.leftBarButtonItem
            popoverPresentationController.delegate = self
            present(popoverController, animated: true, completion: nil)
        }
    }

    private func bindViewModel() {
        assert(viewModel != nil, "viewModel cannot be nil")
        let textFilter = searchBar.rx.text.asDriver()
        let input = SearchLocationVM.Input(textFilter: textFilter)

        let output = viewModel.transform(input: input)

        bindToTableView(output.tableItems)

        output.error
            .drive(onNext: presentError)
            .disposed(by: disposeBag)

        output.isLoading
            .drive(onNext: showLoading)
            .disposed(by: disposeBag)
    }

    private func bindToTableView(_ tableItems: Driver<[Suggestion]>) {
        let dataSource = RxTableViewSectionedAnimatedDataSource<Section>(configureCell: configureCell)

        tableItems
            .do(onNext: { [weak self] suggestions in
                self?.hideTableView(suggestions.isEmpty)
            })
            .map { [Section(model: "Suggestions", items: $0)] }
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

    }

    private func configureCell(dataSource: TableViewSectionedDataSource<Section>,
                               tableView: UITableView,
                               indexPath: IndexPath,
                               item: Suggestion) -> UITableViewCell {
        weak var _self = self
        guard let self = _self else { return UITableViewCell() }

        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.name,
                                                 for: indexPath) as! SearchTableViewCell
        cell.titleLabel.text = item.label
        cell.subtitleLabel.text = "suggestions.distance".localizedWithFormat(arguments: item.distance)
        return cell
    }

    private func hideTableView(_ hide: Bool) {
        tableView.isHidden = hide
    }
}

// MARK: - UIPopoverPresentationControllerDelegate, SortPopoverControllerDelegate
extension SearchLocationVC: UIPopoverPresentationControllerDelegate, SortPopoverControllerDelegate {
    func didSelectSort(controller: SortPopoverController, didSelectItem sort: SortType) {
        viewModel.changeSort(sort)
    }

    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
