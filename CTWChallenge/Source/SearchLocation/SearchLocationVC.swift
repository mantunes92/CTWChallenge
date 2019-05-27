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
}

class SearchLocationVC: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!

    //This viewModel is injected by SearchLocationCoordinator
    var viewModel: SearchLocationVM!
    weak var navigationDelegate: SearchLocationNavigationDelegate?

    typealias Section = AnimatableSectionModel<String, Suggestion>

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindViewModel()
    }

    private func bindViewModel() {
        assert(viewModel != nil, "viewModel cannot be nil")
        let textFilter = searchBar.rx.text.asDriver()
        let input = SearchLocationVM.Input(textFilter: textFilter)

        let output = viewModel.transform(input: input)

        bindToTableView(output.tableItems)

        output.error
            .drive(onNext: showError)
            .disposed(by: disposeBag)

        output.isLoading
            .drive(onNext: handleLoading)
            .disposed(by: disposeBag)
    }

    private func bindToTableView(_ tableItems: Driver<[Suggestion]>) {
        tableView.register(UINib(nibName: SearchTableViewCell.name, bundle: Bundle.main),
                           forCellReuseIdentifier: SearchTableViewCell.name)

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
        cell.titleLabel.text = "\(item.distance)"

        return cell
    }

    private func hideTableView(_ hide: Bool) {
        tableView.isHidden = hide
    }

    private func showError(_ error: Error) {
        let alertVC = UIAlertController(title: "Error",
                                        message: error.localizedDescription,
                                        preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Ok", style: .default)

        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }

    private func handleLoading(_ bool: Bool) {
        bool ? view.showLoading() : view.hideLoading()
    }
}
