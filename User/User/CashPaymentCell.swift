//
//  CashPaymentCell.swift
//  User
//
//  Created by User on 10/5/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class CashPaymentCell: UITableViewCell {

    
    @IBOutlet weak var cashImageViewOutlet: UIImageView!
    
    @IBOutlet weak var cashLabelOutlet: UILabel!
    
    @IBOutlet weak var payByCashLabelOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 7
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
