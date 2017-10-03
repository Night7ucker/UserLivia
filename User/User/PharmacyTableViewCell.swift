//
//  PharmacyTableViewCell.swift
//  User
//
//  Created by User on 10/3/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class PharmacyTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var pharmacyPictureImageViewOutlet: UIImageView!
    
    @IBOutlet weak var pharmacyNameLabelOutlet: UILabel!
    
    @IBOutlet weak var pharmacyAddressLabelOutlet: UILabel!
    
    
    @IBOutlet weak var pharmacyDayWorkingLabelOutlet: UILabel!
    
    
    @IBOutlet weak var choosePharmacyButtonOutlet: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        choosePharmacyButtonOutlet.layer.cornerRadius = 2
        choosePharmacyButtonOutlet.backgroundColor = UIColor(red: CGFloat(121/255.0), green: CGFloat(181/255.0), blue: CGFloat(208/255.0), alpha: CGFloat(1.0))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
