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
    @IBOutlet private weak var searchBar: UISearchBar!
    
    private var currencies: [Currency] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupTableView()
        searchBar.delegate = self
        hideKeyboardByTapping()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateData()
    }
    
    private func getData() {
        CurrencyService.shared.getCurrencies(completion: { [weak self] currencies in
            self?.currencies = currencies
            self?.tableView.reloadData()
        })
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: Constants.allCellID, bundle: nil),
                           forCellReuseIdentifier: Constants.allCellID)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func updateData() {
        currencies = CurrencyService.shared.getCurrencies()
        tableView.reloadData()
    }
}

// MARK: - UISearchBarDelegate

extension AllCurrenciesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            updateData()
            return
        }
        
        currencies = CurrencyService.shared.getCurrencies().filter { (item: Currency) -> Bool in
            return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

// MARK: - SetFavoriteDelegate

extension AllCurrenciesViewController: SetFavoriteDelegate {
    func updateCurrency(currency: Currency) {
        for (index, item) in currencies.enumerated() {
            if item == currency {
                currencies[index].isFavorite = !currency.isFavorite
            }
        }
        tableView.reloadData()
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
        cell.configure(with: currencies[indexPath.row], delegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let exchangeViewController = ExchangeViewController.instantiateExchangeViewController()
        exchangeViewController.configure(with: currencies[indexPath.row])
        exchangeViewController.hidesBottomBarWhenPushed = true
        self.present(exchangeViewController, animated: true)
    }
}

// MARK: - Static

extension AllCurrenciesViewController {
    private static var allCurrenciesStoryboard: UIStoryboard {
        UIStoryboard(name: Constants.viewControllerID, bundle: .main)
    }
    
    static func instantiateAllCurrenciesViewController() -> AllCurrenciesViewController {
        let allCurrenciesViewController = allCurrenciesStoryboard.instantiateViewController(withIdentifier: Constants.viewControllerID) as! AllCurrenciesViewController
        return allCurrenciesViewController
    }
}
