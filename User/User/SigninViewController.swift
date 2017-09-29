//
//  SigninViewController.swift
//  User
//
//  Created by User on 9/29/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {

    @IBOutlet weak var signinButtonOutlet: UIButton!
    
    
    @IBOutlet weak var continueButtonOutlet: UIButton!
    
    let lightBlueColor = UIColor(red: CGFloat(121/255.0), green: CGFloat(181/255.0), blue: CGFloat(208/255.0), alpha: CGFloat(1.0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signinButtonOutlet.layer.cornerRadius = 2
        continueButtonOutlet.layer.cornerRadius = 2
        signinButtonOutlet.backgroundColor = lightBlueColor
        continueButtonOutlet.setTitleColor(lightBlueColor, for: .normal)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signinButtonTapped(_ sender: UIButton) {
        let mainViewStoryboard = UIStoryboard(name: "MainViewStoryboard", bundle: nil)
        let registrationViewController = mainViewStoryboard.instantiateViewController(withIdentifier: "kRegistrationViewController") as? RegistrationViewController
        navigationController?.pushViewController(registrationViewController!, animated: true)
    }
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
