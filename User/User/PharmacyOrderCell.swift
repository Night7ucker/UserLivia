//
//  PharmacyOrderCell.swift
//  User
//
//  Created by User on 10/4/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class PharmacyOrderCell: UITableViewCell {

    @IBOutlet weak var pharmacyNameLabelOutlet: UILabel!
    
    
    @IBOutlet weak var pharmacyAddressLabelOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
