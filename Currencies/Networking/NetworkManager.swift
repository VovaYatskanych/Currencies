//
//  NetworkManager.swift
//  Currencies
//
//  Created by Volodymyr Yatskanych on 11.07.2022.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private var baseurl = "https://api.exchangerate.host/latest"
    
    func getCurrencies(completion: @escaping (Result<CurrencyResponse, Error>) -> Void) {
        guard let url = URL(string: baseurl) else { return }
        
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
                    }                }
            }
            dataTask.resume()
        }
    }
}
