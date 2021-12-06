//
//  ViewController.swift
//  CryptoPiggy
//
//  Created by Paweł Brzozowski on 21/10/2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // Storing assets data
    var assets: [Asset]?
    
    var currentLabelValue: Double = 0.0
    
    var fetchedCoin: NSFetchedResultsController<Asset>?
    
    // Reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let appDelagate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         
        // Setting up tableView
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        // Get all data from Core Data
        fetchAssets()
    }
    
    // Function for fetching assets data form CoreData
    func fetchAssets() {
        // Fetch data form CoreData by passing Request to grab all Assets data
        do {
            // Asing data from CoreData to local data
            self.assets = try context.fetch(Asset.fetchRequest())
            
            // Reload tableView. This is UI work so put this in background.
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            print("CoreData: assets count = \(self.assets!.count)")
            setPortfolioValueLabel()
        } catch {
            
        }
    }
    
    func setPortfolioValueLabel() {
        var listOfAssets = [Asset]()
        if assets != nil {
            for singleAsset in assets! {
                listOfAssets.append(singleAsset)
            }
            setLabelValue(coins: listOfAssets)
        } else {
            valueLabel.text = "No coins"
        }
    }
    
    func setLabelValue(coins: [Asset]) {
        var ValueToSet = 0.0
        
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
                        for coin in tmp_coin_list {
                            for asset in coins {
                                if coin.name == asset.name {
                                    ValueToSet += coin.price_usd! * asset.quantity
                                }
                            }
                        }
                        let stringValue = String(format: "%.2f", ValueToSet)
                        self.valueLabel.text = stringValue + " $"
                        print("Label val should be: " + stringValue)
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
    
    @IBAction func tmpDelateBUtton(_ sender: Any) {
        // Object to delete
        for asset in self.assets! {
            // Remove the asset
            self.context.delete(asset)
            
            // Save the data
            do {
                try self.context.save()
            } catch {
                print("Error while delting data")
            }
        }
        
        // Refetch data
        self.fetchAssets()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assets!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssetCell", for: indexPath) as! AssetTableViewCell
        
        let coin = assets![indexPath.row]
        
        cell.configureCell(coin: coin)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delegateAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
            
            // Get a ref to the note to be deleted
            let coinToDelate = self.assets![indexPath.row]
            
            print(coinToDelate)
            
            // Pass it to delete form CoreData
            self.context.delete(coinToDelate)
            
            // Save the context
            self.appDelagate.saveContext()
            
            // Refresh data for tableView
            self.fetchAssets()
        }
        
        // Rturning action b
        return UISwipeActionsConfiguration(actions: [delegateAction])
    }

}

