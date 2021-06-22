//
//  ViewController.swift
//  TestGrid
//
//  Created by Vorapon Sirimahatham on 6/6/21.
//

import UIKit

class IndiceCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){
        print("Unwind From Add Indice Scene")
        if let indiceIndex = Store.queryList.last {
//            self.loadIndicieData(index: indiceIndex)
            print("load on unwind \(indiceIndex)")
        }
    }
    
    // Collection Cell Configuration - - - -
    let columns: CGFloat = 2.0
    let inset: CGFloat = 1.0
    let spacing: CGFloat = 0.5
    let lineSpacing: CGFloat = 2.0
    let cellHeight : Int = 110
    let headerHeight : Int = 0

    // Data for View - - - -
    var number : Int = 0
    var Store = IndiceStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Add Lastupdated date and time to label
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy HH:mm:ss"
        let current = Date()
        lastUpdateLabel.text = "Last Update " + formatter.string(from: current)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addIndiceSegue" {
            
            let navVC = segue.destination as? UINavigationController
            let addIndicesVC = navVC?.viewControllers.first as! AddIndicesViewController

            addIndicesVC.queryList = Store.queryList
            addIndicesVC.callback = { list in
                if let index = list.last {
                    self.loadIndicieData(index: index)
                }
                self.Store.queryList = addIndicesVC.queryList
            }
        }
        print("addIndiceSegue")
    }
    
    func loadIndicieData( index : String ) {
            // Load data function copy from MenuViewController, it does the same thing
            // but difference place and time to run, find way to improve
    
            print("Load new indiceee \(index)")
            print(Store.getCurrentDataURLinStringBy(index: index))
            guard  let url = URL( string : Store.getCurrentDataURLinStringBy(index: index) ) else {
                print("Checkpoint 1")
                return }
            var dataTask : URLSessionDataTask?
            dataTask?.cancel() // Cancel working task before start new task, only one task should work
            dataTask = URLSession.shared.dataTask(with: url ) { data, resp, err in
            
                print("DataTask Callback Start")
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
                        self.collectionView.reloadData()
                    }
                }
            }
            dataTask?.resume() // After you create the task, you must start it by calling its resume()
            print("DataTask Started")
            // ADD Second DataTasks HERE NOW
            var pastDataTask : URLSessionDataTask?
            pastDataTask?.cancel() // Cancel working task before start new task, only one task should work
            guard  let pastUrl = URL( string : Store.getPassDataURLinStringBy(index: index) ) else {
                print("Checkpoint 2")
                return }
            pastDataTask = URLSession.shared.dataTask(with: pastUrl ) { data, resp, err in
            
                print("PastDataTask Callback Start")
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
                        self.collectionView.reloadData()
                    }
                }
            }
            pastDataTask?.resume()
            print("PastDataTask Started")
    }
}

extension IndiceCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Store.indices.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        
        if let cellTemp = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? IndiceCollectionViewCell
        {
            cellTemp.setIndiceData(indice: Store.indices[indexPath.row])
            cell = cellTemp
            cell.backgroundColor = getCellBGColorBy( value:  Store.indices[indexPath.row].percentChangeInDouble  )
            print(Store.indices[indexPath.row].percentChange)
        }
        return cell
    }
    
    func getCellBGColorBy( value : Double ) -> UIColor
    {
        switch value {
        case _ where value == 0 :
            return UIColor(named: "NoChangeBackground") ?? UIColor.white
        case _ where value > 0 &&  value < 1 :
            return UIColor(named: "littleGreen")!
        case _ where value > 1 :
            return UIColor.green
        case _ where value < 0 && value > -1 :
            return UIColor(named: "littleRed")!
        case _ where value < -1 :
            return UIColor.red
        default:
            return UIColor.white
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 200, height: headerHeight)
    }
}


// MARK: UICollectionViewDelegateFlowLayout
extension IndiceCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = Int((collectionView.frame.width / columns) - (inset + spacing))

        return CGSize(width: width, height: cellHeight)
    }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return spacing
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return lineSpacing
  }

}

