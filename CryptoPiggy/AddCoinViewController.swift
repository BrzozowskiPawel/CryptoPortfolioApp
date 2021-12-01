//
//  AddCoinViewController.swift
//  CryptoPiggy
//
//  Created by Paweł Brzozowski on 01/12/2021.
//

import UIKit

class AddCoinViewController: UIViewController {

    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    @IBOutlet weak var amountTextField: UITextField!
    
    
    var coin: Cryptocoin?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getCoinImage()
        priceLabel.text = String(format: "%.6f", coin!.price_usd!) + " $"
        self.navigationItem.title = "Buy \(coin!.name!)"
    }
    
    func getCoinImage() {
        let imageUrl = "https://cryptoicon-api.vercel.app/api/icon/\(self.coin!.asset_id.lowercased())"
        let url = URL(string: imageUrl)
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if error == nil && data != nil {
                    DispatchQueue.main.async {
                        self.coinImage.image = UIImage(data: data!)
                    }
                }
            }

        dataTask.resume()
    }
    
    @IBAction func amountTextFieldChanged(_ sender: UITextField) {
        let amount = (sender.text! as NSString).doubleValue
        costLabel.text = String(format: "%.2f", (amount * coin!.price_usd!)) + " $"
    }
    
    
    @IBAction func buyButtonTapped(_ sender: Any) {
        
        
    }
    

}
