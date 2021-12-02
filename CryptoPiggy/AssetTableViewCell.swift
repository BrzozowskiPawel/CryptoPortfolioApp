//
//  AssetTableViewCell.swift
//  CryptoPiggy
//
//  Created by Paweł Brzozowski on 02/12/2021.
//

import UIKit

class AssetTableViewCell: UITableViewCell {

    @IBOutlet weak var assetImage: UIImageView!
    @IBOutlet weak var assetAmmount: UILabel!
    @IBOutlet weak var assetValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(coin: Asset) {
        assetAmmount.text = String(format: "%.6f coin", coin.quantity)
        getValuteOfCoinString(coinFromCoreData: coin)
        
        let imageUrl = "https://cryptoicon-api.vercel.app/api/icon/\(coin.name!.lowercased())"
        let url = URL(string: imageUrl)
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if error == nil && data != nil {
                    DispatchQueue.main.async {
                        // Display the image data in the image view
                        self.assetImage.image =  UIImage(data: data!)
                    }
                }
            }

        dataTask.resume()
    }
    
    func getValuteOfCoinString(coinFromCoreData: Asset){
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
                            if coin.type_is_crypto == 1 && coin.price_usd != nil && coinFromCoreData.name == coin.name {
                                let value = (coinFromCoreData.quantity*coin.price_usd!)
                                self.assetValue.text = String(format: "%.2f", value) + " $"
                            }
                        }

                    }
                } catch {
                    print("‼️ There was an error while decoding JSON (asset table view cell).")
                }
                
            } else {
                print("‼️ error: \(error), response: \(response).")
            }
        }
        
        // Start the data task
        dataTask.resume()
    }
}


