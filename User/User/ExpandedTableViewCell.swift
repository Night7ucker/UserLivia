//
//  ExpandedTableViewCell.swift
//  User
//
//  Created by User on 10/2/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class ExpandedTableViewCell: UITableViewCell {

    @IBOutlet weak var radioButtonOutlet: UIImageView!
    
    @IBOutlet weak var dataLabelOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
