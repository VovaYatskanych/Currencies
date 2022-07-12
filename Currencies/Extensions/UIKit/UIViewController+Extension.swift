//
//  UIViewController+Extension.swift
//  Currencies
//
//  Created by Volodymyr Yatskanych on 12.07.2022.
//

import UIKit

extension UIViewController {
    func hideKeyboardByTapping() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
