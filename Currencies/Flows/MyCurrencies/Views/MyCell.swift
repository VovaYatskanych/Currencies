//
//  MyCell.swift
//  Currencies
//
//  Created by Volodymyr Yatskanych on 11.07.2022.
//

import UIKit

final class MyCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    
    func configure(with title: String) {
        titleLabel.text = title
    }
}
