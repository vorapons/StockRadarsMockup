//
//  CollectionViewCell.swift
//  TestGrid
//
//  Created by Vorapon Sirimahatham on 7/6/21.
//

import UIKit

class IndiceCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet var indiceNameLabel : UILabel!
    @IBOutlet var valueLabel : UILabel!
    @IBOutlet var changeLabel : UILabel!
    @IBOutlet var percentChangeLabel : UILabel!

    
    func setLabel( text : String )
    {
        indiceNameLabel.text = text
    }
    
    func setIndiceData( indice : Indice){
        indiceNameLabel.text = indice.name
        valueLabel.text = indice.value
        changeLabel.text = indice.change
        percentChangeLabel.text = indice.percentChange + "%"
    }
    
    
}
