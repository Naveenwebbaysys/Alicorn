//
//  ContactTableViewCell.swift
//  Alicorn
//
//  Created by Mac on 03/05/23.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var placeholerLbl : UILabel!
    @IBOutlet weak var contactTF : UITextField!
    @IBOutlet weak var errorLbl : UILabel!
    @IBOutlet weak var errorheight: NSLayoutConstraint!
    @IBOutlet weak var dropDownBtn : UIButton!
    var isRequired = Bool()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
