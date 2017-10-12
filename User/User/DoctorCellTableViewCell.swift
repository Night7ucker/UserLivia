//
//  DoctorCellTableViewCell.swift
//  User
//
//  Created by User on 10/12/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class DoctorCellTableViewCell: UITableViewCell {

    @IBOutlet weak var doctorImageViewOutlet: UIImageView!
    
    
    @IBOutlet weak var doctorNameLabelOutlet: UILabel!
    
    @IBOutlet weak var doctorAddressLabelOutlet: UILabel!
    
    @IBOutlet weak var doctorExperienceLabelOutelt: UILabel!
    
    @IBOutlet weak var doctorFeeLabelOutlet: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
