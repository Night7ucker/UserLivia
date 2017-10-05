//
//  ChangePhoneNumberVC.swift
//  User
//
//  Created by User on 10/5/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class ChangePhoneNumberVC: RootViewController, PopupCountryCodesTableViewControllerDelegate {
    

    
    
    @IBOutlet weak var previousPhoneCodeLabelOutlet: UILabel!
    
    @IBOutlet weak var previousCountryFlagImageViewOutlet: UIImageView!
    
    
    @IBOutlet weak var previousPhoneNumberLabelOutlet: UILabel!
    
    
    @IBOutlet weak var newPhoneNumberImageViewOutlet: UIImageView!
    
    @IBOutlet weak var newPhoneCodeLabelOutlet: UILabel!
    
    @IBOutlet weak var newPhoneNumberTextFieldOutlet: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        previousPhoneCodeLabelOutlet.text = RealmDataManager.getUserDataFromRealm()[0].phoneCode
        previousPhoneNumberLabelOutlet.text = RealmDataManager.getUserDataFromRealm()[0].phoneNumber
        let imageURL = "https://test.liviaapp.com" + getUserCountryImageURL(userPhoneCode: RealmDataManager.getUserDataFromRealm()[0].phoneCode!)!
        getImage(pictureUrl: imageURL) { success, image in
            if success {
                self.previousCountryFlagImageViewOutlet.image = image
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func sendCountryInfo(index: Int) {
        newPhoneCodeLabelOutlet.text = RealmDataManager.getDataFromCountries()[index].phoneCode
        let imageURL = "https://test.liviaapp.com" + RealmDataManager.getDataFromCountries()[index].countryFlag!
        getImage(pictureUrl: imageURL) { success, image in
            if success {
                self.newPhoneNumberImageViewOutlet.image = image
            }
            
        }
    }
    
    func getUserCountryImageURL(userPhoneCode: String) -> String? {
        for flagImageURL in RealmDataManager.getDataFromCountries() {
            if flagImageURL.phoneCode == userPhoneCode {
                return flagImageURL.countryFlag
            }
        }
        return nil
    }
    
    @IBAction func countryCodeAndFlagTapped(_ sender: UIButton) {
        let supportingViewControllersStoryboard = UIStoryboard(name: "SupportingViewControllersStoryboard", bundle: nil)
        let popupCountryCodesViewController = supportingViewControllersStoryboard.instantiateViewController(withIdentifier: "kPopupCountryCodesTableViewController") as! PopupCountryCodesTableViewController
        popupCountryCodesViewController.delegate = self
        present(popupCountryCodesViewController, animated: false, completion: nil)
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
