//
//  ViewController.swift
//  User
//
//  Created by BAMFAdmin on 22.09.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//
// TODO:
// change image size on this controlller (so it fits images from popup table view)

import UIKit


class RegistrationViewController: UIViewController {

    @IBOutlet weak var nextButtonOutlet: UIButton!
    @IBOutlet weak var mainWhiteViewOutlet: UIView!
    @IBOutlet weak var skipRegistrationButtonOutlet: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       

        
      
        nextButtonOutlet.layer.cornerRadius = 10
        mainWhiteViewOutlet.layer.cornerRadius = 10
        skipRegistrationButtonOutlet.layer.cornerRadius = 10
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changePhoneCodeForCountryButtonTapped(_ sender: UIButton) {
        
    }

}

