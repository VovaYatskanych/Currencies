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
    private var rateUrl = "https://api.exchangerate.host/convert?from=EUR&to=*&amount=#"
    
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
        
        let complexUrl = rateUrl.replacingOccurrences(of: "*", with: currency)
            .replacingOccurrences(of: "#", with: String(amount))
        
        guard let url = URL(string: complexUrl) else { return }
        
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

struct Rate: Decodable {
    let result: Float
}
