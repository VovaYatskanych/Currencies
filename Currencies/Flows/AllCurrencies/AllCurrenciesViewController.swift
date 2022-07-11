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
    
    private var currencies: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupUI()
    }
    
    private func getData() {
        NetworkManager.shared.getCurrencies { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let response):
                self?.currencies = Array(response.rates.keys)
                self?.tableView.reloadData()
            }
        }
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
        currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.allCellID, for: indexPath) as? AllCell else {
            return UITableViewCell()
        }
        cell.configure(with: currencies[indexPath.row])
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
