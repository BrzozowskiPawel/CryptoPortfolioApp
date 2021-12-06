//
//  CryptocoinModel.swift
//  CryptoPiggy
//
//  Created by Paweł Brzozowski on 30/11/2021.
//

import Foundation

protocol CryptoCoinProtocol {
    func coinsRetrieved(_ cryptocoins:[Cryptocoin])
}

class CryptocoinModel{
    var delegate: CryptoCoinProtocol?
    
    func getCoins() {
        // Creating a string for URL
        let stringURL = "https://rest-sandbox.coinapi.io/v1/assets/?apikey=34CA68B6-FBB2-42F5-90DB-AF182307568A"
        
        // Create a URL request object
        let url = URL(string: stringURL)
        
        // Check if url object isn't nil
        guard url != nil else{
            print("‼️ URL object is NIL.")
            return
        }
        
        // Create the URL Session
        let session = URLSession.shared
        
        // Crete the dataTask
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if error == nil && data != nil {
                
                // Try to parse JSON
                let decoder = JSONDecoder()
                do {
                    // Parsing a JSON into the Cryptocoin
                    let coinsArrayDecoded = try decoder.decode([Cryptocoin].self, from: data!)
                    DispatchQueue.main.async {
                        var tmp_coin_list = [Cryptocoin]()
                        
                        for coin in coinsArrayDecoded {
                            if coin.type_is_crypto == 1 && coin.price_usd != nil {
                                tmp_coin_list.append(coin)
                            }
                        }
                        
                        self.delegate?.coinsRetrieved(tmp_coin_list)
                    }
                } catch {
                    print("‼️ There was an error while decoding JSON.")
                }
                
            } else {
                print("‼️ error: \(error), response: \(response).")
            }
        }
        
        // Start the data task
        dataTask.resume()
    }
    
}
