//
//  AddCoinViewController.swift
//  CryptoPiggy
//
//  Created by Paweł Brzozowski on 01/12/2021.
//

import UIKit
import CoreData

class AddCoinViewController: UIViewController {

    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    
    var coin: Cryptocoin?
    
    // Reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getCoinImage()
        priceLabel.text = String(format: "%.6f", coin!.price_usd!) + " $"
        self.navigationItem.title = "Buy \(coin!.name!)"
        self.amountTextField.placeholder = "Amount of \(coin!.name!)"
    }
    
    // Dowloading image for specyfic coin
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
    
    // TODO: Update before saving if there is some data for specyfic coin
    @IBAction func buyButtonTapped(_ sender: Any) {
        // Crete asset object by creating it in the context
        let newAsset = Asset(context: self.context)
        
        // Save properties for new asset object
        newAsset.name = coin?.name
        newAsset.quantity = (amountTextField.text! as NSString).doubleValue
        
        // Save data
        do {
            try self.context.save()
        } catch {
            print("‼️ ERROR while saving to context")
        }
        
        // Dissmising buy VC
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}


