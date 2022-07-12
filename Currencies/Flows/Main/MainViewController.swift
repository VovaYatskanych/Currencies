//
//  MainViewController.swift
//  Currencies
//
//  Created by Volodymyr Yatskanych on 11.07.2022.
//

import UIKit

final class MainViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        let myCurrenciesViewController = MyCurrenciesViewController.instantiateMyCurrenciesViewController()
        let allCurrenciesViewController = AllCurrenciesViewController.instantiateAllCurrenciesViewController()
        setViewControllers([allCurrenciesViewController, myCurrenciesViewController], animated: true)
        
        tabBar.items?[.zero].image = UIImage(systemName: "house")
        tabBar.items?[.zero].badgeColor = .gray
        tabBar.items?[.zero].title = "All Currencies"
        
        tabBar.items?[1].image = UIImage(systemName: "star")
        tabBar.items?[1].badgeColor = .gray
        tabBar.items?[1].title = "My Currencies"
    }
}
