//
//  ViewController.swift
//  CryptoPiggy
//
//  Created by Paweł Brzozowski on 21/10/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // Storing assets data
    var assets: [Asset]?
    
    // Reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting up tableView
//        tableView.delegate = self
//        tableView.dataSource = self
        
        // Get all data from Core Data
        fetchAssets()
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
            
        } catch {
            
        }
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

//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: <#T##String#>, for: <#T##IndexPath#>)
//    }
//
//
//}

