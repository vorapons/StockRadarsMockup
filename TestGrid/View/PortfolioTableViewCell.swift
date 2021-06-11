//
//  PortfolioTableViewCell.swift
//  TestGrid
//
//  Created by Vorapon Sirimahatham on 7/6/21.
//

import UIKit

class PortfolioTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pendingPLabel: UILabel!
    @IBOutlet weak var WDablePLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var logoImage: UIImageView! {
        didSet {
            logoImage.layer.cornerRadius = 30.0
            logoImage.clipsToBounds = true
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   

}
