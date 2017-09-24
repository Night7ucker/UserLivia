//
//  MainScreenCell.swift
//  User
//
//  Created by Egor Yanukovich on 9/24/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class MainScreenCell: UITableViewCell {

        
    @IBOutlet weak var mainScreenImage: CustomImageView!
   
    @IBOutlet weak var mainIcon: UIImageView!
    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
