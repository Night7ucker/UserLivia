//
//  OrderDescriptionTableViewCell.swift
//  User
//
//  Created by BAMFAdmin on 04.10.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class OrderDescriptionTableViewCell: UITableViewCell {

    @IBOutlet var drugsReceptImage: UIImageView!
    @IBOutlet var drugName: UILabel!

    @IBOutlet var drugCurrencyLabel: UILabel!
    @IBOutlet var drugPriceLabel: UILabel!
    @IBOutlet var selfCollectValue: UILabel!
    @IBOutlet var drugQuantityMeasure: UILabel!
    @IBOutlet var drugAmount: UILabel!
    @IBOutlet var drugsPreviewImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

 
