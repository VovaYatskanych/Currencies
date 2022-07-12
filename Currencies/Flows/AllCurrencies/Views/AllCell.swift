//
//  AllCell.swift
//  Currencies
//
//  Created by Volodymyr Yatskanych on 11.07.2022.
//

import UIKit

final class AllCell: UITableViewCell {
    private struct Constants {
        static let cornerRadius: CGFloat = 6
        static let buttonAddTitle = "Add"
        static let buttonRemoveTitle = "Remove"
    }

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var addButton: UIButton!

    private weak var delegate: SetFavoriteDelegate?
    private var currency: Currency?
        
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func configure(with currency: Currency, delegate: SetFavoriteDelegate) {
        self.currency = currency
        self.delegate = delegate
        titleLabel.text = currency.name
        configureAddButton(isSelected: !currency.isFavorite)
    }

    private func setupUI() {
        addButton.layer.cornerRadius = Constants.cornerRadius
    }
    
    private func configureAddButton(isSelected: Bool) {
        if isSelected {
            addButton.isSelected = false
            addButton.setTitle(Constants.buttonAddTitle, for: .normal)
            addButton.backgroundColor = .gray
        } else {
            addButton.isSelected = true
            addButton.setTitle(Constants.buttonRemoveTitle, for: .normal)
            addButton.backgroundColor = .lightText
        }
    }
}

// MARK: - Actions

private extension AllCell {
    @IBAction func addButtonPressed(_ sender: UIButton) {
        guard let currency = currency else { return }
        CurrencyService.shared.setNewStatus(for: currency)
        delegate?.updateCurrency(currency: currency)
    }
}
