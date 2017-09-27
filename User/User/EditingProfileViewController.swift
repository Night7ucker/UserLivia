//
//  EditingProfileViewController.swift
//  User
//
//  Created by User on 9/26/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

protocol PopupTitleForPersonViewControllerDelegate: class {
    func trasferUsetTitle(personTitle: String)
}

class EditingProfileViewController: UIViewController, PopupTitleForPersonViewControllerDelegate {
    
    
    @IBOutlet weak var userTitleLabelOutlet: UILabel!
    
    @IBOutlet weak var userNameTextFieldOutlet: UITextField!
    
    @IBOutlet weak var userLastnameTextFieldOutlet: UITextField!
    
    @IBOutlet weak var userCityLabelOutlet: UILabel!
    

    @IBOutlet weak var userAgeTextFieldOutlet: UITextField!
    
    @IBOutlet weak var userSexSegmentedControlOutlet: UISegmentedControl!
    
    @IBOutlet weak var userEmailTextFieldOutlet: UITextField!
    
    
    @IBOutlet weak var userCountryLabelOutlet: UILabel!
    
    @IBOutlet weak var userCountryImageViewOutlet: UIImageView!
    
    @IBOutlet weak var userCountryPhoneCodeLabelOutlet: UILabel!
    
    @IBOutlet weak var userPhoneNumberLabelOutlet: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        backButton.setTitle("", for: .normal)
        
        backButton.setBackgroundImage(UIImage(named: "backButtonImage"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        
        let backButtonBarButton = UIBarButtonItem(customView: backButton)
        
        let titleLabel = UILabel()
        titleLabel.text = "My account"
        titleLabel.textColor = .white
        titleLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        let titleLabelBarButton = UIBarButtonItem(customView: titleLabel)
        
        navigationItem.setLeftBarButtonItems([backButtonBarButton, titleLabelBarButton], animated: true)
        
        let addReminderButton = UIButton(type: .system)
        addReminderButton.frame = CGRect(x: 300, y: 0, width: 70, height: 100)
        addReminderButton.setTitle("✓", for: .normal)
        addReminderButton.titleLabel?.font = UIFont(name: "Arial", size: 25)
        addReminderButton.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: UIFontWeightThin)
        addReminderButton.setTitleColor(.white, for: .normal)
        addReminderButton.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 0, -60)
        addReminderButton.addTarget(self, action: #selector(confrimedTapped(_ :)), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addReminderButton)
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.4, green: 0.8, blue: 0.7, alpha: 1)
        
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        navigationController?.navigationBar.layer.shadowRadius = 4.0
        navigationController?.navigationBar.layer.shadowOpacity = 0.5
        navigationController?.navigationBar.layer.masksToBounds = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
    
    func confrimedTapped(_ sender: UIButton) {
        print("confirmed")
    }
    
    
    @IBAction func userChangeTitleButtonTapped(_ sender: UIButton) {
        let registrationModule = UIStoryboard(name: "RegistrationModule", bundle: nil)
        let popupTitleForPersonViewController = registrationModule.instantiateViewController(withIdentifier: "kPopupTitleForPersonViewController") as? PopupTitleForPersonViewController
        popupTitleForPersonViewController?.delegate = self
        present(popupTitleForPersonViewController!, animated: false, completion: nil)
    }
    
    func trasferUsetTitle(personTitle: String) {
        userTitleLabelOutlet.text = personTitle
    }

    
    @IBAction func changeUserPictureButtonTapped(_ sender: UIButton) {
    }
    
    
    @IBAction func changeSexSegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("female")
        case 1:
            print("male")
        default:
            break
        }
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
