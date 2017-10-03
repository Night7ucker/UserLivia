//
//  OrderPageCell.swift
//  User
//
//  Created by Egor Yanukovich on 9/27/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class OrderPageCell: UITableViewCell {
    
    

    @IBOutlet var statusLabelOutlet: UILabel!
    @IBOutlet weak var orderStatusImage: UIImageView!
    @IBOutlet var orderIDLabelOutlet: UILabel!
    @IBOutlet var dateLabelOutlet: UILabel!
    @IBOutlet var selfCollectLabelOutlet: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension OrderPageCell {
    func fillCellInfo(orderStatusImage: UIImage) {

        self.orderStatusImage.image = orderStatusImage
    }
}
