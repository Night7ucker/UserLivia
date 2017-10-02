//
//  Contact.swift
//  User
//
//  Created by Egor Yanukovich on 10/2/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import Contacts

class Contact: NSObject {

    var name : String?
    var phoneNumber:String?
    var contactImage : UIImage?
    
    init(name:String, phoneNumber:String, contactImage : UIImage) {
        
        self.name = name
        self.phoneNumber = phoneNumber
        self.contactImage = contactImage
        
      super.init()
    }

    init?(cnContact: CNContact) {
        
        // name
        if !cnContact.isKeyAvailable(CNContactGivenNameKey) && !cnContact.isKeyAvailable(CNContactFamilyNameKey) { return nil }
        self.name = (cnContact.givenName + " " + cnContact.familyName).trimmingCharacters(in: CharacterSet.whitespaces)
        // phone
        if cnContact.isKeyAvailable(CNContactPhoneNumbersKey) {
            if cnContact.phoneNumbers.count > 0 {
                let phone = cnContact.phoneNumbers.first?.value
                self.phoneNumber = (phone?.stringValue)!
            }
        }
        // image
        self.contactImage = (cnContact.isKeyAvailable(CNContactImageDataKey) && cnContact.imageDataAvailable) ? UIImage(data: cnContact.imageData!) : nil
        
        
        
    }
}
