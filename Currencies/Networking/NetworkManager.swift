//
//  NetworkManager.swift
//  Currencies
//
//  Created by Volodymyr Yatskanych on 11.07.2022.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private var currenciesUrl = "https://api.exchangerate.host/latest"
    private var rateUrl = "https://api.exchangerate.host/convert"
    
    func getCurrencies(completion: @escaping (Result<CurrencyResponse, Error>) -> Void) {
        guard let url = URL(string: currenciesUrl) else { return }
        
        DispatchQueue.global().async {
            let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
                
                guard let data = data else { return }
                do {
                    let currencies = try JSONDecoder().decode(CurrencyResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(currencies))
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    func getRate(for currency: String, amount: Float, completion: @escaping (Result<Rate, Error>) -> Void) {
        let queryItems = [URLQueryItem(name: "from", value: "EUR"),
                          URLQueryItem(name: "to", value: currency),
                          URLQueryItem(name: "amount", value: String(amount))]
        
        guard var urlComponents = URLComponents(string: rateUrl) else { return }
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else { return }
                
        DispatchQueue.global().async {
            let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
                
                guard let data = data else { return }
                do {
                    let currencies = try JSONDecoder().decode(Rate.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(currencies))
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
            dataTask.resume()
        }
    }
}
