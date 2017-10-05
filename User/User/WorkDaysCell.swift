//
//  WorkDaysCell.swift
//  User
//
//  Created by User on 10/5/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class WorkDaysCell: UITableViewCell {

    @IBOutlet weak var workDayImageViewOutlet: UIImageView!
    
    @IBOutlet weak var workingTimeLabelOutlet: UILabel!
    
    @IBOutlet weak var workDayBackgroundOutlet: UIImageView!
    
    @IBOutlet weak var launchBreakLabelOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
