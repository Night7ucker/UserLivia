//
//  TestTableViewCell.swift
//  User
//
//  Created by User on 9/30/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class TestTableViewCell: UITableViewCell {
    @IBOutlet weak var testLabelOutlet: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
