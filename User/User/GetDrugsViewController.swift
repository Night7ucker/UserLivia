//
//  GetDrugsViewController.swift
//  User
//
//  Created by BAMFAdmin on 27.09.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class GetDrugsViewController: UIViewController {

    @IBOutlet var drugNameTextFieldOutlet: UITextField!
    
    @IBOutlet var drugNameButtonOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet var goToDrugPageAction: UIButton!
}
