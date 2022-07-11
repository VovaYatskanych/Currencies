//
//  MyCurrenciesViewController.swift
//  Currencies
//
//  Created by Volodymyr Yatskanych on 11.07.2022.
//

import UIKit

final class MyCurrenciesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension MyCurrenciesViewController {
    private static var myCurrenciesStoryboard: UIStoryboard {
        UIStoryboard(name: "MyCurrencies", bundle: .main)
    }
    
    static func instantiateMyCurrenciesViewController() -> MyCurrenciesViewController {
        let myCurrenciesViewController = myCurrenciesStoryboard.instantiateViewController(withIdentifier: "MyCurrencies") as! MyCurrenciesViewController
        return myCurrenciesViewController
    }
}
