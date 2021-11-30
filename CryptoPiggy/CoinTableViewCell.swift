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
    }
}
