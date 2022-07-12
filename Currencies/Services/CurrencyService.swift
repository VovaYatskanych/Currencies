//
//  CurrencyService.swift
//  Currencies
//
//  Created by Volodymyr Yatskanych on 12.07.2022.
//

import Foundation

final class CurrencyService {
    static let shared = CurrencyService()
    
    private var currencies: [Currency] = []
    
    func getCurrencies(completion: @escaping ([Currency]) -> Void) {
        NetworkManager.shared.getCurrencies { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let response):
                guard let strongSelf = self else { return }
                let sortedArray = Array(response.rates.keys).sorted { $0 < $1 }
                sortedArray.forEach {
                    strongSelf.currencies.append(Currency(name: $0))
                }
                completion(strongSelf.currencies)
            }
        }
    }
    
    func setNewStatus(for currency: Currency) {
        for (index, item) in currencies.enumerated() {
            if item == currency {
                currencies[index].isFavorite = !currency.isFavorite
            }
        }
    }
    
    func getCurrencies() -> [Currency] {
        currencies
    }
}
