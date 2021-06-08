//
//  MenuViewController.swift
//  TestGrid
//
//  Created by Vorapon Sirimahatham on 7/6/21.
//

import UIKit

class MenuViewController: UITableViewController{

    var menus = ["Indices", "Portfolio"]
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){
        print("Unwind")
    }
    
    @IBAction func dismissButtonClicked(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
        print("testest")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Menus"
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        if( indexPath.row == 0)
        {
            let cellIdentifier = "menuCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            // Configure the cell...
            cell.textLabel?.text = menus[indexPath.row]

            return cell
        }
        else{
            let cellIdentifier = "menuCell2"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            // Configure the cell...
            cell.textLabel?.text = menus[indexPath.row]

            return cell
        }
    }

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menus.count
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showIndice" {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                let destinationController = segue.destination as! ViewController
//                
//            }
//        }
//    }
    

}
