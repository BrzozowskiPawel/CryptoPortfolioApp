//
//  CoinTableViewCell.swift
//  CryptoPiggy
//
//  Created by Paweł Brzozowski on 30/11/2021.
//

import UIKit

class CoinTableViewCell: UITableViewCell {

    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var coinPriceLabel: UILabel!
    
    var coin: Cryptocoin?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(coin: Cryptocoin) {
        self.coin = coin
        coinNameLabel.text = coin.name!
        coinPriceLabel.text = "\(coin.price_usd!)$"
        
        let imageUrl = "https://cryptoicon-api.vercel.app/api/icon/\(self.coin!.asset_id.lowercased())"
        let url = URL(string: imageUrl)
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if error == nil && data != nil {
                    DispatchQueue.main.async {
                        // Display the image data in the image view
                        self.coinImage.image =  UIImage(data: data!)
                    }
                }
            }

        dataTask.resume()
        }
}
