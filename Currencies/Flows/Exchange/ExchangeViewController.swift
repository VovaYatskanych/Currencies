//
//  ExchangeViewController.swift
//  Currencies
//
//  Created by Volodymyr Yatskanych on 12.07.2022.
//

import UIKit

final class ExchangeViewController: UIViewController {
    private struct Constants {
        static let viewControllerID = "Exchange"
    }
    
    @IBOutlet private weak var amountTextField: UITextField!
    @IBOutlet private weak var currencyLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    private var currency: Currency?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amountTextField.delegate = self
        amountTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        currencyLabel.text = currency?.name
    }
    
    func configure(with currency: Currency) {
        self.currency = currency
    }
    
    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        guard let amount = textField.text,
              let floatAmount = Float(amount),
              let currency = currency else { return }
        
        NetworkManager.shared.getRate(for: currency.name, amount: floatAmount) { [weak self] result in
            switch result {
            case .success(let rate):
                self?.resultLabel.text = "\(rate.result)"
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ExchangeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}

// MARK: - Static

extension ExchangeViewController {
    private static var exchangeStoryboard: UIStoryboard {
        UIStoryboard(name: Constants.viewControllerID, bundle: .main)
    }
    
    static func instantiateExchangeViewController() -> ExchangeViewController {
        let exchangeViewController = exchangeStoryboard.instantiateViewController(withIdentifier: Constants.viewControllerID) as! ExchangeViewController
        return exchangeViewController
    }
}
