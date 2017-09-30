//
//  CountryCodeCell.swift
//  User
//
//  Created by User on 9/22/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class CountryCodeCell: UITableViewCell {

    @IBOutlet weak var countryNameLabelOutlet: UILabel!
    @IBOutlet weak var countryFlagImageViewOutlet: UIImageView!
    @IBOutlet weak var countryCodeLabelOutlet: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension CountryCodeCell {
    func fillCellInfo(countryName: String, countryCode: String) {
        self.countryNameLabelOutlet.text = countryName
        self.countryCodeLabelOutlet.text = countryCode
    }
}
