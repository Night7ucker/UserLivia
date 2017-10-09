//
//  PaymentPageCell.swift
//  User
//
//  Created by Egor Yanukovich on 9/27/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class PaymentPageCell: UITableViewCell {
    

    @IBOutlet var paymentData: UILabel!
    @IBOutlet var paymentOrderId: UILabel!
    @IBOutlet var paymentText: UILabel!
    @IBOutlet var paymentPrice: UILabel!
    @IBOutlet var paymentImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

