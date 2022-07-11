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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        titleLabel.text = "Test"
        addButton.layer.cornerRadius = Constants.cornerRadius
        configureAddButton(isSelected: true)
    }
    
    private func configureAddButton(isSelected: Bool) {
        if isSelected {
            addButton.isSelected = false
            addButton.setTitle(Constants.buttonAddTitle, for: .normal)
            addButton.backgroundColor = .gray
        } else {
            addButton.isSelected = true
            addButton.setTitle(Constants.buttonRemoveTitle, for: .normal)
            addButton.backgroundColor = .lightGray
        }
    }
}

// MARK: - Actions

private extension AllCell {
    @IBAction func addButtonPressed(_ sender: UIButton) {
        configureAddButton(isSelected: sender.isSelected)
    }
}
