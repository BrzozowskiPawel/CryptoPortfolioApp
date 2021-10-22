//
//  SingleCryptoTableViewCell.swift
//  CryptoPiggy
//
//  Created by Paweł Brzozowski on 22/10/2021.
//

import UIKit

struct SingleCryptoTableViewCellModel {
    let name: String
    let symbol: String
    let price: Float
}
class SingleCryptoTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with viewModel: SingleCryptoTableViewCellModel) {
        nameLabel.text = viewModel.name
        priceLabel.text = String(format: "%.6f", viewModel.price)
        subLabel.text = viewModel.symbol
    }

}
