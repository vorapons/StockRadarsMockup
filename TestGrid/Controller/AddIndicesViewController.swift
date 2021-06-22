//
//  AddIndicesViewController.swift
//  StockRadarsMockUp
//
//  Created by Vorapon Sirimahatham on 15/6/21.
//

import UIKit
import CoreData

class AddIndicesViewController: UITableViewController {

    var indicesList : [IndiceList] = []
    var searchResult : [IndiceList] = []
    var queryList : [String] = []
    
    // Callback fn for returning updated Indices list
    var callback : (([String])->())?
    
    var searchController: UISearchController!
    @IBOutlet var listTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let listData = listJson.data(using: .utf8)
        do { indicesList = try JSONDecoder().decode([IndiceList].self, from: listData!) }
        catch { print(error) }
        print("Loaded Indices list for selection = \(indicesList.count)")
        
        searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
    }
    func sendBackUpdatedQueryList(){
        // send data back to IndiceCollectionVC to check and load added Indice Index
        callback?(queryList)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected = \(indicesList[indexPath.row].symbol)")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if( searchController.isActive )
        {   return searchResult.count }
        
        return    indicesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "indicesListCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! IndiesListViewCell
        // Configure the cell...
        let thisList : [IndiceList]
        
        if( searchController.isActive )
        {    thisList = searchResult }
        else
        {   thisList = indicesList }
        
        cell.IndiceLabel.text = thisList[indexPath.row].symbol.trimmingCharacters(in: .whitespacesAndNewlines)
        cell.message = thisList[indexPath.row].symbol.trimmingCharacters(in: .whitespacesAndNewlines)
        cell.delegate = self

        return cell
    }
    
    func UpdateSearchResultFrom(searchText: String = "") {
        var searchResults = indicesList.filter({ (indice) -> Bool in
            let isMatch = indice.symbol.localizedCaseInsensitiveContains(searchText)
            return isMatch
        })
        if searchText == ""
        { searchResults = indicesList }
        self.searchResult = searchResults
    }

}

extension AddIndicesViewController: UISearchResultsUpdating {
    
    // Put search text to filter function here
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        UpdateSearchResultFrom(searchText: searchText)
        listTableView.reloadData()
    }
}

extension AddIndicesViewController : MyTableViewCellDelegate {
    
    func didTapButton(with title: String) {
        print("Click at \(title)")
        queryList.append(title)
        sendBackUpdatedQueryList()
        self.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
}
