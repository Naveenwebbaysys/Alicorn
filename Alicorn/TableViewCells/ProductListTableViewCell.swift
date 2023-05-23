//
//  ProductListTableViewCell.swift
//  Alicorn
//
//  Created by Mac on 23/05/23.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productDescLbl : UILabel!
    @IBOutlet weak var nmfcLbl : UILabel!
    @IBOutlet weak var packageTypeLbl : UILabel!
    @IBOutlet weak var editBtn : UIButton!
    @IBOutlet weak var deleteBtn : UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
