//
//  SmsConfrimViewController.swift
//  User
//
//  Created by User on 9/23/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import RealmSwift

class SmsConfrimViewController: UIViewController {
    @IBOutlet weak var sendCodeAgainButtonOutlet: UIButton!
    @IBOutlet weak var textViewForCodeOutlet: UITextField!
    @IBOutlet weak var confirmButtonOutlet: UIButton!
    @IBOutlet var smsHasBeenSentInfo: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
   //RealmDataManager.getPhoneNumberFromRealm()[0].phoneNumber!
        
        
        
        sendCodeAgainButtonOutlet.layer.borderColor = UIColor.gray.cgColor
        sendCodeAgainButtonOutlet.layer.borderWidth = 0.2
        sendCodeAgainButtonOutlet.layer.cornerRadius = 2
        confirmButtonOutlet.layer.cornerRadius = 2
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
