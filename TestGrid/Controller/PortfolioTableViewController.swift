//
//  PortfolioTableViewController.swift
//  TestGrid
//
//  Created by Vorapon Sirimahatham on 7/6/21.
//

import UIKit
import SDWebImage

class PortfolioTableViewController: UITableViewController {

    lazy var dataSource = configureDataSource()
    var portData : [Portfolio] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        navigationController?.navigationBar.prefersLargeTitles = true
    
        // Add on
        let jsonData = portJSON.data(using: .utf8)
        do {
            self.portData = try JSONDecoder().decode([Portfolio].self, from: jsonData!)
        } catch {
            print(error)
        }
//        print(portData)
        
        tableView.dataSource = configureDataSource()
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Portfolio>()
        snapshot.appendSections([.all])
        snapshot.appendItems(portData, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: false)
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return portData.count
    }
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, Portfolio> {

        let cellIdentifier = "portCell"
        // Lec 12 : UITableViewDiffableDataSource<Section, Restaurant> -> RestaurantDiffableDataSource
        let dataSource = UITableViewDiffableDataSource<Section, Portfolio> (
            tableView: tableView,
            cellProvider: {  tableView, indexPath, portfolio in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PortfolioTableViewCell
                // Custom Cell Option here
                cell.titleLabel.text = portfolio.title
                cell.WDablePLabel.text = String(format: "%.2f",portfolio.withdrawable_point)
                cell.pendingPLabel.text = String(format: "%.2f",portfolio.pending_point)
                cell.changeLabel.text = self.DoubleToStringChangeFormat( portfolio.change )
                if( portfolio.change == 0)
                { cell.changeLabel.textColor = UIColor.orange }
                else {
                    cell.changeLabel.textColor = portfolio.change > 0 ? UIColor(named: "MossGreen") : UIColor.red
                }
                
                cell.logoImage.sd_setImage(with: portfolio.image_plan, placeholderImage: UIImage(systemName: "xmark.seal") ) { dlImage, dlException, cacheType, dlURL in
                    
                    if dlException != nil {
                        if let url = dlURL {
                            print( "\(url) got problem" )
                        }
                        else
                        { print("Got error in URL")}
                    }
                }

                return cell
            }
        )
        return dataSource
    }
    
    func DoubleToStringChangeFormat(_ value : Double ) -> String {
        var output : String = " "
        output.append("(")
        if value > 0
        {output.append("+") }
        else if value < 0
        {output.append("-")}
        output.append(String(format: "%.2f",value))
        output.append(")")
        return output
    }
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
