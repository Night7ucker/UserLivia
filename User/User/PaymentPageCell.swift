//
//  PaymentPageCell.swift
//  User
//
//  Created by Egor Yanukovich on 9/27/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class PaymentPageCell: UITableViewCell {
    
    
    @IBOutlet weak var priceOfOrderLabel: UILabel!
    
    @IBOutlet weak var dateAndIdlabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!

    @IBOutlet weak var typeOfCardImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
