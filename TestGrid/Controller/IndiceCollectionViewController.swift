//
//  ViewController.swift
//  TestGrid
//
//  Created by Vorapon Sirimahatham on 6/6/21.
//

import UIKit

class IndiceCollectionViewController:  UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    
    // Collection Cell Configuration - - - -
    let columns: CGFloat = 2.0
    let inset: CGFloat = 1.0
    let spacing: CGFloat = 0.5
    let lineSpacing: CGFloat = 2.0
    let cellHeight : Int = 110
    let headerHeight : Int = 0
    
    
    // Data for View - - - -
    var indicesData : [Indice] = []
    var number : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Add on
        let jsonData = json.data(using: .utf8)
        do {
            self.indicesData = try JSONDecoder().decode([Indice].self, from: jsonData!)
        } catch {
            print(error)
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy HH:mm:ss"
        let current = Date()
        lastUpdateLabel.text = "Last Update " + formatter.string(from: current)
    }
}

extension IndiceCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return indicesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        
        if let cellTemp = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? IndiceCollectionViewCell
        {
            cellTemp.setIndiceData(indice: indicesData[indexPath.row])
            cell = cellTemp
            let percentChangeValue = Double(indicesData[indexPath.row].percentChange) ?? 0.0
            cell.backgroundColor = getCellBGColorBy( value: percentChangeValue )
        }
        return cell
    }
    
    func getCellBGColorBy( value : Double ) -> UIColor
    {
        switch value {
        case _ where value == 0 :
            return UIColor.yellow
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
//
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        switch kind {
////            case UICollectionView.elementKindSectionHeader :
//////                if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderCollectionReusableView {
//////                    //headerView.lastUpdateTimeLabel.text = "Last Update 02 June 2021 22:49:23"
//////                    return headerView
//////                }
//
//            default:
//               print(" Not Found Header")
//                return UICollectionReusableView()
//
//        }
//        return UICollectionReusableView()
//    }
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
