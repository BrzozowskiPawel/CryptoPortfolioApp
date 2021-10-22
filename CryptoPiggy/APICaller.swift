//
//  APICaller.swift
//  CryptoPiggy
//
//  Created by Paweł Brzozowski on 22/10/2021.
//

import Foundation


final class APICaller {
    static let shared = APICaller()
    
    private struct Constrants {
        static let apiKey = "34CA68B6-FBB2-42F5-90DB-AF182307568A"
        static let assetsEndpoint = "https://rest-sandbox.coinapi.io/v1/assets/"
    }
    private init() {}
    
    // MARK: - Public
    public func getAllCryptoData(complition: @escaping (Result<[Crypto],Error>) -> Void ) {
        guard let url = URL(string: Constrants.assetsEndpoint + "?apikey=" + Constrants.apiKey) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                // Decoding data into Crypto (models file) objects
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                complition(.success(cryptos))
            }
            catch {
                complition(.failure(error))
            }
        }
        task.resume()
    }
    
}
