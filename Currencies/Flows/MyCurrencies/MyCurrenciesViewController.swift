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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        tableView.register(UINib(nibName: Constants.myCellID, bundle: nil),
                           forCellReuseIdentifier: Constants.myCellID)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MyCurrenciesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.myCellID, for: indexPath) as? MyCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

extension MyCurrenciesViewController {
    private static var myCurrenciesStoryboard: UIStoryboard {
        UIStoryboard(name: Constants.viewControllerID, bundle: .main)
    }
    
    static func instantiateMyCurrenciesViewController() -> MyCurrenciesViewController {
        let myCurrenciesViewController = myCurrenciesStoryboard.instantiateViewController(withIdentifier: Constants.viewControllerID) as! MyCurrenciesViewController
        return myCurrenciesViewController
    }
}
