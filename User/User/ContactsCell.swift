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
        
        let alert = UIAlertController(title: "SMS send", message: "Send sms to \(self.contactNameLabel.text ?? self.contactPhoneLabel.text!)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            print("Sending via sms to \(self.contactPhoneLabel.text!)")
        }))
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func configureWithContactEntry(_ contact: Contact) {
        contactNameLabel.text = contact.name
        contactPhoneLabel.text = contact.phoneNumber ?? ""
        contactImage.image = contact.contactImage ?? UIImage(named: "defaultUser")
        
    }
}
