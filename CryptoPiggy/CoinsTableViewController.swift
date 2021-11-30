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
        
        return cell
    }
    
    
}
extension CoinsTableViewController: CryptoCoinProtocol {
    func coinsRetrieved(_ cryptocoins: [Cryptocoin]) {
        // Setting up values for crypto coins array
        self.coins = cryptocoins
        
        // Setting up title
        self.navigationItem.title = "\(self.coins.count) coins founded 🔎"
        
        // Reloading data after dowloading
        tableView.reloadData()
    }
}
