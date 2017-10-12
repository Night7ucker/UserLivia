//
//  FindDoctorCellTableViewCell.swift
//  User
//
//  Created by User on 10/9/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class FindDoctorCellTableViewCell: UITableViewCell {

    var specializationID: String?
    var specializationName: String?
    @IBOutlet weak var imageViewOutlet: UIImageView!
    
    @IBOutlet weak var specializationNameLabelOutlet: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
