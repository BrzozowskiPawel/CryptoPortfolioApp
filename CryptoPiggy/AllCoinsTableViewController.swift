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
                                               price: "$1")
            })
                
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
