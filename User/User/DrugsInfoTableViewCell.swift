//
//  DrugsInfoTableViewCell.swift
//  User
//
//  Created by BAMFAdmin on 29.09.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class DrugsInfoTableViewCell: UITableViewCell {

    @IBOutlet var drugsName: UILabel!
    
    @IBOutlet var drugsDescLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}
