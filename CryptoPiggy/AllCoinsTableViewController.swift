//
//  AllCoinsTableViewController.swift
//  CryptoPiggy
//
//  Created by Paweł Brzozowski on 21/10/2021.
//
import UIKit

class AllCoinsTableViewController: UITableViewController {

    private var viewModels = [SingleCryptoTableViewCellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        APICaller.shared.getAllCryptoData { [weak self] result in
            switch result {
            case .success(let models):
                self?.viewModels = models.compactMap({
                SingleCryptoTableViewCellModel(name: $0.name ?? "N/A",
                                               symbol: $0.asset_id,
                                               price: $0.price_usd ?? 0
                )
                                                
            })
                self?.viewModels = validateData(orginalArray: self!.viewModels)
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("error \(error)")
            }
        }
    }

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModels.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "SingleCryptoTableViewCellIdentifier",
            for: indexPath) as? SingleCryptoTableViewCell
        else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
        
    }
    


}
// Validating if coins from API have price in USD and also are cryptocurrency not real currency.
func validateData( orginalArray: [SingleCryptoTableViewCellModel]) -> [SingleCryptoTableViewCellModel] {
    var tmpArray = [SingleCryptoTableViewCellModel]()
    for item in orginalArray {
            if item.price != 0{
                tmpArray.append(item)
            }
    }
    return tmpArray
}
