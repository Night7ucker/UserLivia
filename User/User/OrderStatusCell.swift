//
//  OrderStatusCell.swift
//  User
//
//  Created by Egor Yanukovich on 9/28/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class OrderStatusCell: UITableViewCell {
    
    @IBOutlet weak var orderFilterDescrLabel: UILabel!
    @IBOutlet weak var orderCheckImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension OrderStatusCell {
    func fillCellInfo(orderFilterDescription: String, orderCheckImage: UIImage) {
        self.orderFilterDescrLabel.text = orderFilterDescription
        self.orderCheckImage.image = orderCheckImage
    }
}
