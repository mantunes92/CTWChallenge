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

protocol SearchLocationNavigationDelegate: class {
    // Definition of navigation methods
}

class SearchLocationVC: UIViewController {

    //This viewModel is injected by SearchLocationCoordinator
    var viewModel: SearchLocationVM!

    weak var navigationDelegate: SearchLocationNavigationDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindViewModel()
    }

    let repo: RepositoryProvider = RepositoryProviderImpl()
    let disposeBag = DisposeBag()
    private func bindViewModel() {
        assert(viewModel != nil, "viewModel cannot be nil")
        let input = SearchLocationVM.Input()

        let output = viewModel.transform(input: input)


        //        repo.makeSuggestionsRepository().getLocations(named: "t")
        //            .subscribe(onSuccess: { result in
        //                print("SUCESSO")
        //            }) { error in
        //                print("ERRO -> \(error.localizedDescription)" )
        //        }
        //        .disposed(by: disposeBag)

        repo.makeLocationDetailRepository().getLocationDetail(id: "NT_Opil2LPZVRLZjlWNLJQuWB_0ITN",
                                                              position: Position(latitude: 2,
                                                                                 longitude: 2))
            .subscribe(onNext: { result in
                print("SUCESSO")
            }, onError: { error in
                print("ERRO -> \(error.localizedDescription)" )
            })
            .disposed(by: disposeBag)

    }
}
