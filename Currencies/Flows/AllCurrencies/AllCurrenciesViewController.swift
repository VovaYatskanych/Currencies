//
//  AllCurrenciesViewController.swift
//  Currencies
//
//  Created by Volodymyr Yatskanych on 11.07.2022.
//

import UIKit

final class AllCurrenciesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        view.backgroundColor = .yellow
    }
}

extension AllCurrenciesViewController {
    private static var allCurrenciesStoryboard: UIStoryboard {
        UIStoryboard(name: "AllCurrencies", bundle: .main)
    }
    
    static func instantiateAllCurrenciesViewController() -> AllCurrenciesViewController {
        let allCurrenciesViewController = allCurrenciesStoryboard.instantiateViewController(withIdentifier: "AllCurrencies") as! AllCurrenciesViewController
        return allCurrenciesViewController
    }
}
