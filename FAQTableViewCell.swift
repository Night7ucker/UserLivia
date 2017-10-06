//
//  FAQTableViewCell.swift
//  User
//
//  Created by BAMFAdmin on 06.10.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class FAQTableViewCell: UITableViewCell {

    @IBOutlet var descOutlet: UITextView!
    @IBOutlet var titleFirst: UILabel!
    @IBOutlet var titleSecond: UILabel!
    @IBOutlet var bottom: UILabel!
    @IBOutlet var top: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
