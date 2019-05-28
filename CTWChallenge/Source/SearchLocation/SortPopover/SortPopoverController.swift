//
//  SortPopoverController.swift
//  CTWChallenge
//
//  Created by Marcelo Antunes on 5/28/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import UIKit

protocol SortPopoverControllerDelegate:class {
    func didSelectSort(controller: SortPopoverController, didSelectItem sort: SortType)
}

class SortPopoverController: UIViewController {

    weak var delegate: SortPopoverControllerDelegate?
    var initialSelection: SortType?

    private let picker = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()

        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.delegate = self
        picker.dataSource = self

        view.addSubview(picker)
        picker.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        picker.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        picker.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        picker.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let selection = initialSelection {
            picker.selectRow(SortType.allCases.firstIndex(of: selection)!,
                             inComponent: 0,
                             animated: false)
        }

    }
}

extension SortPopoverController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SortType.allCases.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return SortType.allCases[row].rawValue
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.didSelectSort(controller: self, didSelectItem: SortType.allCases[row])
    }
}
