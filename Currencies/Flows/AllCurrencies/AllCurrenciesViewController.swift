//
//  AllCurrenciesViewController.swift
//  Currencies
//
//  Created by Volodymyr Yatskanych on 11.07.2022.
//

import UIKit

final class AllCurrenciesViewController: UIViewController {
    private struct Constants {
        static let allCellID = "AllCell"
        static let viewControllerID = "AllCurrencies"
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupUI()
    }
    
    private func setupUI() {
        tableView.register(UINib(nibName: Constants.allCellID, bundle: nil),
                           forCellReuseIdentifier: Constants.allCellID)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension AllCurrenciesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.allCellID, for: indexPath) as? AllCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension AllCurrenciesViewController {
    private static var allCurrenciesStoryboard: UIStoryboard {
        UIStoryboard(name: Constants.viewControllerID, bundle: .main)
    }
    
    static func instantiateAllCurrenciesViewController() -> AllCurrenciesViewController {
        let allCurrenciesViewController = allCurrenciesStoryboard.instantiateViewController(withIdentifier: Constants.viewControllerID) as! AllCurrenciesViewController
        return allCurrenciesViewController
    }
}
