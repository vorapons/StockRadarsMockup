//
//  IndiesListViewCell.swift
//  StockRadarsMockUp
//
//  Created by Vorapon Sirimahatham on 17/6/21.
//

import UIKit

class IndiesListViewCell: UITableViewCell {

    weak var delegate : MyTableViewCellDelegate?
    
    @IBOutlet weak var IndiceLabel: UILabel!
    
    @IBOutlet weak var AddButton: UIButton!
    
    var message : String?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func onAddButtonClicked(_ sender: Any) {
        delegate?.didTapButton(with: self.message ?? "A")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

protocol  MyTableViewCellDelegate : AnyObject{

    func didTapButton(with title : String)

}
