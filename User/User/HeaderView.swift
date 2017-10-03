//
//  HeaderView.swift
//  User
//
//  Created by Egor Yanukovich on 10/2/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class HeaderView: UITableViewCell {

   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func inviteAllFriends(_ sender: UIButton) {
        let alert = UIAlertController(title: "SMS Send", message: "Send sms to All", preferredStyle: .alert)
        alert.view.tintColor = UIColor(red: 0.44, green: 0.65, blue: 0.75, alpha: 1.0)
        
        alert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            print("Sending via sms to all")
        }))
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        
    }
    
}
