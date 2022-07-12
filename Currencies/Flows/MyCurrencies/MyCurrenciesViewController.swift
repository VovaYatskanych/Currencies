//
//  MyCurrenciesViewController.swift
//  Currencies
//
//  Created by Volodymyr Yatskanych on 11.07.2022.
//

import UIKit

final class MyCurrenciesViewController: UIViewController {
    private struct Constants {
        static let myCellID = "MyCell"
        static let viewControllerID = "MyCurrencies"
    }

    @IBOutlet private weak var tableView: UITableView!
    
    private var currencies: [Currency] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateData()
    }
    
    private func setupUI() {
        tableView.register(UINib(nibName: Constants.myCellID, bundle: nil),
                           forCellReuseIdentifier: Constants.myCellID)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func updateData() {
        currencies = CurrencyService.shared.getCurrencies().filter({ $0.isFavorite })
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MyCurrenciesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.myCellID, for: indexPath) as? MyCell else {
            return UITableViewCell()
        }
        cell.configure(with: currencies[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let exchangeViewController = ExchangeViewController.instantiateExchangeViewController()
        exchangeViewController.configure(with: currencies[indexPath.row])
        exchangeViewController.hidesBottomBarWhenPushed = true
        self.present(exchangeViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CurrencyService.shared.setNewStatus(for: currencies[indexPath.row])
            updateData()
        }
    }
}

// MARK: - Static

extension MyCurrenciesViewController {
    private static var myCurrenciesStoryboard: UIStoryboard {
        UIStoryboard(name: Constants.viewControllerID, bundle: .main)
    }
    
    static func instantiateMyCurrenciesViewController() -> MyCurrenciesViewController {
        let myCurrenciesViewController = myCurrenciesStoryboard.instantiateViewController(withIdentifier: Constants.viewControllerID) as! MyCurrenciesViewController
        return myCurrenciesViewController
    }
}
