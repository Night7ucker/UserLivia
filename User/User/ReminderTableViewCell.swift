//
//  ReminderTableViewCell.swift
//  User
//
//  Created by User on 9/25/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class ReminderTableViewCell: UITableViewCell {

    @IBOutlet weak var medicineNameLabelOutlet: UILabel!
    @IBOutlet weak var reminderDateLabelOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension ReminderTableViewCell {
    func fillCellInfo(medicineName: String, remiderDate: String) {
        self.medicineNameLabelOutlet.text = medicineName
        self.reminderDateLabelOutlet.text = remiderDate
    }
}
