//
//  CurrencyResponse.swift
//  Currencies
//
//  Created by Volodymyr Yatskanych on 11.07.2022.
//

struct CurrencyResponse: Decodable {
    let base: String
    let rates: [String: Double]
}
