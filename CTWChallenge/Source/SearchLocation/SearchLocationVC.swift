//
//  SearchLocationVC.swift
//  CTWChallenge
//
//  Created by Marcelo Antunes on 5/21/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import UIKit

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

    private func bindViewModel() {
        assert(viewModel != nil, "viewModel cannot be nil")
        let input = SearchLocationVM.Input()

        let output = viewModel.transform(input: input)

    }
}
