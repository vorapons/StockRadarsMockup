//
//  MenuViewController.swift
//  TestGrid
//
//  Created by Vorapon Sirimahatham on 7/6/21.
//

import UIKit

class MenuViewController: UITableViewController {

    var Store = IndiceStore()   // Main data store here
    
    var menus = ["Indices", "Portfolio"]
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){
        print("Unwind to MenuView")
        if let sourceViewController = unwindSegue.source as? IndiceCollectionViewController {
            self.Store = sourceViewController.Store
        }
    }
    
    @IBAction func dismissButtonClicked(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
        print("testest")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Menus"
        loadIndicieData()
//        loadIndicieMockData() // for dev & debug
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showIndiceData" {
            let destinationController = segue.destination as! IndiceCollectionViewController
            destinationController.Store = self.Store
        }
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menus.count
    }
    
    // MARK: - Loading data from API
    func loadIndicieMockData()
    {
        print("Load Mock Data")
        var indice = Indice()
        indice.name = "DJI"
        indice.valueInDouble = 34406.0
        indice.lastClosedValue = 34629.96875
        indice.lastTwoDaysClosedValue = 34600.05078
        indice.pastAdded = true
        indice.currentAdded = true
        self.Store.indices.append(indice)
    
        indice.name = "N225"
        indice.valueInDouble = 29160.25977
        indice.lastClosedValue = 29005.74023
        indice.lastTwoDaysClosedValue = 28959.33008
        indice.pastAdded = true
        indice.currentAdded = true
        self.Store.indices.append(indice)
        
        indice.name = "HSI"
        indice.valueInDouble = 28847.75
        indice.lastClosedValue = 28778.83008
        indice.lastTwoDaysClosedValue = 28763.66992
        indice.pastAdded = true
        indice.currentAdded = true
        self.Store.indices.append(indice)
    }

    func loadIndicieData() {
        // There are two part of data, Current value index and past index value
        // They are difference API call so load both data and merge them for showing
        // current value and calcucate change value
        // #Way to improve : when index not found it can't throw anything, only do nothing, fix it
        
        for name in Store.queryList {
            
            // Load Current indice data
            guard  let url = URL( string : Store.getCurrentDataURLinStringBy(index: name) ) else { return }
            var dataTask : URLSessionDataTask?
            dataTask?.cancel() // Cancel working task before start new task, only one task should work
            dataTask = URLSession.shared.dataTask(with: url ) { data, resp, err in
            
                if let error = err { print("Failure! \(error.localizedDescription)") }
                else if let httpResponse = resp as? HTTPURLResponse, httpResponse.statusCode == 200 {
                  print("Success! \(data!)")
                }
                else if let httpResponse = resp as? HTTPURLResponse, httpResponse.statusCode == 404 {
                    print("404 Data not found")
                    return
                }
                guard let httpdata = data else {
                    print( err.debugDescription )
                    return
                }
                print("Loaded data \(httpdata)")
                if let decodedData = try? JSONDecoder().decode( CurrentIndice.self, from : httpdata ) {
                    DispatchQueue.main.async {
                        self.Store.addIndiceCurrentData(data: decodedData)
                    }
                }
            }
            dataTask?.resume() // After you create the task, you must start it by calling its resume()
            
            // Load Past indice data
            var pastDataTask : URLSessionDataTask?
            pastDataTask?.cancel() // Cancel working task before start new task, only one task should work
            guard  let pastUrl = URL( string : Store.getPassDataURLinStringBy(index: name) ) else { return }
            pastDataTask = URLSession.shared.dataTask(with: pastUrl ) { data, resp, err in
            
                if let error = err { print("Failure! \(error.localizedDescription)") }
                else if let httpResponse = resp as? HTTPURLResponse, httpResponse.statusCode == 200 {
                  print("Success! \(data!)")
                }
                else if let httpResponse = resp as? HTTPURLResponse, httpResponse.statusCode == 404 {
                    print("404 Data not found")
                    return
                }
                guard let httpdata = data else {
                    print( err.debugDescription )
                    return
                }
                print("Loaded data \(httpdata)")
                if let decodedData = try? JSONDecoder().decode( PastIndice.self, from : httpdata ) {
                    DispatchQueue.main.async {
                        self.Store.addIndicePastData(data: decodedData)
                        print("Teste")
                    }
                }
            }
            pastDataTask?.resume()
        }
    }
}


