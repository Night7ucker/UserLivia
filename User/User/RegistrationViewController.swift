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

class RegistrationViewController: RootViewController, PopupCountryCodesTableViewControllerDelegate, SmsConfrimViewControllerDelegate {
    
    @IBOutlet weak var nextButtonOutlet: UIButton!
    @IBOutlet weak var mainWhiteViewOutlet: UIView!
    @IBOutlet weak var skipRegistrationButtonOutlet: UIButton!
    
    @IBOutlet var countryImage: UIImageView!
    @IBOutlet var countryCode: UILabel!
    @IBOutlet var countryName: UILabel!
    
    @IBOutlet var phoneNumberField: UITextField!
    
    @IBOutlet weak var errorViewOutlet: UIView!
    
    @IBOutlet weak var wrongPhoneNumberViewOutlet: UIView!
    
    
    let realm = try! Realm()
    let countryCodeDataManagerObject = GetCountryCodesRequest()
    
    var indexOfCountry = 2
    
    var canSendNewCode = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        try! realm.write {
            realm.deleteAll()
        }
        
        hideKeyboardWhenTappedAround()
        
        nextButtonOutlet.backgroundColor = Colors.Root.lightBlueColor
        errorViewOutlet.isHidden = true
        wrongPhoneNumberViewOutlet.isHidden = true
        nextButtonOutlet.layer.cornerRadius = 2
        skipRegistrationButtonOutlet.layer.cornerRadius = 2
        skipRegistrationButtonOutlet.setTitleColor(Colors.Root.lightBlueColor, for: .normal)
        nextButtonOutlet.layer.shadowOffset = .zero
        nextButtonOutlet.layer.shadowRadius = 1
        nextButtonOutlet.layer.shadowColor = UIColor.black.cgColor
        nextButtonOutlet.layer.shadowOpacity = 0.8
        mainWhiteViewOutlet.layer.borderColor = UIColor.white.cgColor
        
        nextButtonOutlet.transform = CGAffineTransform(scaleX: 0.8, y: 1.2) // initial view distorted scale so it has a starting point for the animation
        
        UIView.animate(withDuration: 0.6, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.nextButtonOutlet.transform = .identity // get back to original scale in an animated way
        }, completion: nil)
        
//        UIView.transition(with: view, duration: 5, options: .transitionCrossDissolve, animations: { _ in
//            self.mainWhiteViewOutlet.isHidden = true
//        }, completion: nil)
        
        //        mainWhiteViewOutlet.addCornerRadiusAnimation(from: 800, to: 10, duration: 0.5) { success in
        //            if success {
        //                self.mainWhiteViewOutlet.layer.shadowOffset = .zero
        //                self.mainWhiteViewOutlet.layer.shadowRadius = 1
        //                self.mainWhiteViewOutlet.layer.shadowColor = UIColor.black.cgColor
        //                self.mainWhiteViewOutlet.layer.shadowOpacity = 0.8
        //            }
        //        }
        
        phoneNumberField.delegate = self
        
        navigationController?.isNavigationBarHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let countryCodesObject = GetCountryCodesRequest()
        countryCodesObject.getCountryCodes()
        let urlBelarusFlagImage = "https://test.liviaapp.com/images/flags/32x32/by.png"
        getImage(pictureUrl: urlBelarusFlagImage) { success, image in
            if success {
                self.countryImage.image = image
            }
        }
        countryName.text = "Belarus"
        countryCode.text = "+375"
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= 37
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += 37
            }
        }
    }
    
    @IBAction func sendAuthCodeAction(_ sender: Any) {
        let textFieldString = phoneNumberField.text! as NSString
        if textFieldString.length < 9 {
            wrongPhoneNumberViewOutlet.isHidden = false
            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(hideWrongPhoneNumberView), userInfo: nil, repeats: false)
            return
        }
        if canSendNewCode {
            let phoneNumberObject = PhoneNumberModel()
            phoneNumberObject.phoneNumber = phoneNumberField.text!
            
            if RealmDataManager.getPhoneNumberFromRealm().count > 0 {
                try! realm.write {
                    realm.delete(RealmDataManager.getPhoneNumberFromRealm())
                }
            }
            RealmDataManager.writeIntoRealm(object: phoneNumberObject)
            
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
    
    func hideWrongPhoneNumberView() {
        wrongPhoneNumberViewOutlet.isHidden = true
    }
    
    
    @IBAction func changePhoneCodeForCountryButtonTapped(_ sender: UIButton) {
        
    }
    
    func sendCountryInfo(index: Int) {
        indexOfCountry = index
        let countryObject = RealmDataManager.getDataFromCountries()[indexOfCountry]
        countryCode.text = "+" + countryObject.phoneCode!
        countryName.text = countryObject.countryName
        let urlImage = "https://test.liviaapp.com" + countryObject.countryFlag!
        getImage(pictureUrl: urlImage) { success, image in
            if success {
                self.countryImage.image = image
            }
        }
    }
    
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

extension UIView
{
    func addCornerRadiusAnimation(from: CGFloat, to: CGFloat, duration: CFTimeInterval, completion: @escaping (Bool) -> Void)
    {
        let animation = CABasicAnimation(keyPath:"cornerRadius")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.fromValue = from
        animation.toValue = to
        animation.duration = duration
        self.layer.add(animation, forKey: "cornerRadius")
        self.layer.cornerRadius = to
        completion(true)
    }
}
