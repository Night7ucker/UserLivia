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
import RealmSwift

class RegistrationViewController: UIViewController{
    
    @IBOutlet weak var nextButtonOutlet: UIButton!
    @IBOutlet weak var mainWhiteViewOutlet: UIView!
    @IBOutlet weak var skipRegistrationButtonOutlet: UIButton!
    
    @IBOutlet var countryImage: UIImageView!
    @IBOutlet var countryCode: UILabel!
    @IBOutlet var countryName: UILabel!
    
    @IBOutlet var phoneNumberField: UITextField!
    
    var token = NotificationToken()
    let realm = try! Realm()
    let countryCodeDataManagerObject = CountryCodesDataManager()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumberField.delegate = self
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let countryCodesObject = CountryCodesDataManager()
        countryCodesObject.getCountryCodes()
        
        let urlBelarusFlagImage = "https://test.liviaapp.com/images/flags/32x32/by.png"
        countryCodeDataManagerObject.getImage(pictureUrl: urlBelarusFlagImage) { success, image in
            if success {
                self.countryImage.image = image
            }
        }
        countryName.text = "Belarus"
        countryCode.text = "+375"
        
        token = realm.addNotificationBlock { (notifcation, realm) -> Void in
            let indexOfCountry = RealmDataManager.getIndexCountryFromRealm()
            if indexOfCountry.count > 0 {
                let countryObject = RealmDataManager.getDataFromCountries()[indexOfCountry[0].index]
                
                self.countryCode.text = "+" + countryObject.phoneCode!
                self.countryName.text = countryObject.countryName
                let urlImage = "https://test.liviaapp.com" + countryObject.countryFlag!
                self.countryCodeDataManagerObject.getImage(pictureUrl: urlImage) { success, image in
                    if success {
                        self.countryImage.image = image
                    }
                }
            }
        }
        nextButtonOutlet.layer.cornerRadius = 2
        mainWhiteViewOutlet.layer.cornerRadius = 10
        skipRegistrationButtonOutlet.layer.cornerRadius = 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendAuthCodeAction(_ sender: Any) {
        let phoneNumberObject = PhoneNumberModel()
        phoneNumberObject.phoneNumber = phoneNumberField.text!
        RealmDataManager.writeIntoRealm(object: phoneNumberObject, realm: realm)
        let countryCodeValue = String(countryCode.text!.characters.dropFirst())
        let getAuthCodeObject = GetAuthCode(number: phoneNumberField.text!, code: countryCodeValue)
        getAuthCodeObject.getAutCodeRequest()

        
    }
    
    deinit {
        token.stop()
    }
    
    @IBAction func changePhoneCodeForCountryButtonTapped(_ sender: UIButton) {

    }
    
}


extension RegistrationViewController: UITextFieldDelegate  {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 9
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }

}
