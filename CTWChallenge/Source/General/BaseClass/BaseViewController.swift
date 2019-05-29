//
//  BaseViewController.swift
//  CTWChallenge
//
//  Created by Marcelo Antunes on 5/28/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    @IBOutlet weak var keyboardConstraint: NSLayoutConstraint? {
        didSet {
            initialKeyboardConstraintValue = keyboardConstraint?.constant ?? 0
        }
    }
    private var initialKeyboardConstraintValue: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        maybeRegisterForKeyboardNotif()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unregisterAllNotif()
    }
    
    private func unregisterAllNotif() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    private func maybeRegisterForKeyboardNotif() {
        guard keyboardConstraint != nil else { return }
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillShow),
                                       name: UIResponder.keyboardWillShowNotification,
                                       object: nil)
        
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillHide),
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardConstraint = keyboardConstraint else { return }
        let userInfo = (notification as NSNotification).userInfo!
        let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardConstraint.constant = keyboardSize.size.height +
            (initialKeyboardConstraintValue - view.safeAreaInsets.bottom)
        animateChanges()
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let keyboardConstraint = keyboardConstraint else { return }
        keyboardConstraint.constant = initialKeyboardConstraintValue
        animateChanges()
    }
    
    private func animateChanges() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
}
