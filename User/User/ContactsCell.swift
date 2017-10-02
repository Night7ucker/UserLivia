//
//  ContactsCell.swift
//  User
//
//  Created by Egor Yanukovich on 10/2/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import Contacts

class ContactsCell: UITableViewCell {

    @IBOutlet weak var contactImage: CustomImageView!
    
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactPhoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBAction func sendInvitationToFriend(_ sender: UIButton) {
        
        print("sendInvitationToFriend")
    }
    
    func configureWithContactEntry(_ contact: Contact) {
        contactNameLabel.text = contact.name
        contactPhoneLabel.text = contact.phoneNumber ?? ""
        contactImage.image = contact.contactImage ?? UIImage(named: "defaultUser")
        
    }
}
