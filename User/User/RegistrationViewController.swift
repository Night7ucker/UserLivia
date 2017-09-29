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

protocol PopupCountryCodesTableViewControllerDelegate: class {
    func sendCountryInfo(index: Int)
}

protocol SmsConfrimViewControllerDelegate: class {
    func timeToSentNewCode()
}

class RegistrationViewController: UIViewController, PopupCountryCodesTableViewControllerDelegate, SmsConfrimViewControllerDelegate {
    
    let lightBlueColor = UIColor(red: CGFloat(0/255.0), green: CGFloat(128/255.0), blue: CGFloat(255/255.0), alpha: CGFloat(1.0))
    
    @IBOutlet weak var nextButtonOutlet: UIButton!
    @IBOutlet weak var mainWhiteViewOutlet: UIView!
    @IBOutlet weak var skipRegistrationButtonOutlet: UIButton!
    
    @IBOutlet var countryImage: UIImageView!
    @IBOutlet var countryCode: UILabel!
    @IBOutlet var countryName: UILabel!
    
    @IBOutlet var phoneNumberField: UITextField!
    
    @IBOutlet weak var errorViewOutlet: UIView!
    
    var token = NotificationToken()
    let realm = try! Realm()
    let countryCodeDataManagerObject = CountryCodesDataManager()
    
    var indexOfCountry = 2
    
    var canSendNewCode = true
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        nextButtonOutlet.backgroundColor = UIColor(red: CGFloat(121/255.0), green: CGFloat(181/255.0), blue: CGFloat(208/255.0), alpha: CGFloat(1.0))
        phoneNumberField.delegate = self
        navigationController?.isNavigationBarHidden = true
        errorViewOutlet.isHidden = true
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
        
        nextButtonOutlet.layer.cornerRadius = 2
        mainWhiteViewOutlet.layer.cornerRadius = 10
        skipRegistrationButtonOutlet.layer.cornerRadius = 2
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendAuthCodeAction(_ sender: Any) {
        if canSendNewCode {
            let phoneNumberObject = PhoneNumberModel()
            phoneNumberObject.phoneNumber = phoneNumberField.text!
            
            if RealmDataManager.getPhoneNumberFromRealm().count > 0 {
                try! realm.write {
                    realm.delete(RealmDataManager.getPhoneNumberFromRealm())
                }
            }
            RealmDataManager.writeIntoRealm(object: phoneNumberObject, realm: realm)
            
            let countryCodeValue = String(countryCode.text!.characters.dropFirst())
            let getAuthCodeObject = GetAuthCode(number: phoneNumberField.text!, code: countryCodeValue)
            getAuthCodeObject.getAutCodeRequest()
            
            let registrationStoryboard = UIStoryboard(name: "RegistrationModule", bundle: nil)
            let smsConfirmViewController = registrationStoryboard.instantiateViewController(withIdentifier: "kSmsConfrimViewController") as? SmsConfrimViewController
            smsConfirmViewController?.delegate = self
            smsConfirmViewController?.indexOfCountry = indexOfCountry
            navigationController?.pushViewController(smsConfirmViewController!, animated: true)
            canSendNewCode = false
            
        } else {
            errorViewOutlet.isHidden = false
            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(hideErrorView), userInfo: nil, repeats: false)
            return
        }
        
    }
    
    
    func hideErrorView() {
        errorViewOutlet.isHidden = true
    }
    
    
    deinit {
        token.stop()
    }
    
    @IBAction func changePhoneCodeForCountryButtonTapped(_ sender: UIButton) {
        
    }
    
    func sendCountryInfo(index: Int) {
        indexOfCountry = index
        let countryObject = RealmDataManager.getDataFromCountries()[indexOfCountry]
        countryCode.text = "+" + countryObject.phoneCode!
        countryName.text = countryObject.countryName
        let urlImage = "https://test.liviaapp.com" + countryObject.countryFlag!
        countryCodeDataManagerObject.getImage(pictureUrl: urlImage) { success, image in
            if success {
                self.countryImage.image = image
            }
        }
    }
    
    // showPopupContries
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPopupContries" {
            let popupContriesControllerr = segue.destination as! PopupCountryCodesTableViewController
            
            popupContriesControllerr.delegate = self
        }
    }
    
    func timeToSentNewCode() {
        canSendNewCode = true
    }
    
    
    @IBAction func skipRegistrationButtonTapped(_ sender: UIButton) {
        let mainScreenStoryboard = UIStoryboard(name: "MainScreen", bundle: nil)
        let mainScreenController = mainScreenStoryboard.instantiateViewController(withIdentifier: "kMainScreenController") as? MainScreenController
        mainScreenController?.userIsRegistred = false
        navigationController?.pushViewController(mainScreenController!, animated: true)
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
