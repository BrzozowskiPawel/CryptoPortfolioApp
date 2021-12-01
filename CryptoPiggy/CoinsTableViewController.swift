//
//  CoinsTableViewController.swift
//  CryptoPiggy
//
//  Created by Paweł Brzozowski on 30/11/2021.
//

import UIKit

class CoinsTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // Creting model for retrieving data and coins array to store retrieved data.
    var model = CryptocoinModel()
    var coins = [Cryptocoin]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Seting this class as model's delegate to be able to retrieve data.
        model.delegate = self
        model.getCoins() // Starting dowloading data
        
        // Setting up tableView
        tableView.delegate = self
        tableView.dataSource = self
    }

}
extension CoinsTableViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell", for: indexPath) as! CoinTableViewCell
        
        let coin = coins[indexPath.row]
        cell.configureCell(coin: coin)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Reference to the row that user have selected (index path)
        let indexPath = tableView.indexPathForSelectedRow
        
        // Chech if it's not nil
        guard indexPath != nil else {
            return
        }
        
        // Get coin that have been tapped on
        let coin = coins[indexPath!.row]
        
        // Get a reference to the addCoinViewController
        let addCoinViewController = segue.destination as! AddCoinViewController
        
        // Pass the coin to the addCoinViewController
        addCoinViewController.coin = coin
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Triggering segue for selected row. Detaisl will be set in prepare function
        performSegue(withIdentifier: "buyCoin", sender: self)
    }
    
    
}
extension CoinsTableViewController: CryptoCoinProtocol {
    func coinsRetrieved(_ cryptocoins: [Cryptocoin]) {
        // Setting up values for crypto coins array
        let sortecCryptocoins =  cryptocoins.sorted {
            $0.price_usd! > $1.price_usd!
        }
        self.coins = sortecCryptocoins
        
        // Setting up title
        self.navigationItem.title = "\(self.coins.count) coins founded 🔎"
        
        // Reloading data after dowloading
        tableView.reloadData()
    }
}
