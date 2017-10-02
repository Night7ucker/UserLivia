//
//  AddToCartTableViewCell.swift
//  User
//
//  Created by BAMFAdmin on 02.10.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class AddToCartTableViewCell: UITableViewCell {

    @IBOutlet var nameOfMedicineLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

