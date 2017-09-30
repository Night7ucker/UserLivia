//
//  SmsConfrimViewController.swift
//  User
//
//  Created by User on 9/23/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import RealmSwift


enum UserStatus: String {
    case active = "1"
    case notActive = "2"
    case moderation = "3"
    case refusalToRegister = "4"
    case ban = "5"
    case registrationInProgress = "6"
}


class SmsConfrimViewController: RootViewController {
    
    @IBOutlet weak var textViewForCodeOutlet: UITextField!
    @IBOutlet weak var confirmButtonOutlet: UIButton!
    @IBOutlet weak var timerButtonOutlet: UIButton!
    @IBOutlet weak var spaceLabelOutlet: UILabel!
    @IBOutlet weak var timerLabelOutlet: UILabel!
    @IBOutlet weak var sendCodeAgainLabelOutlet: UILabel!
    @IBOutlet weak var personNumberLabelOutlet: UILabel!
    @IBOutlet var wrongAuthCodeView: UIView!
    
    var indexOfCountry = Int()
    
    var seconds = 120
    var timer = Timer()
    var isTimerRunning = false
    
    let realm = try! Realm()
    
    var delegate: SmsConfrimViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wrongAuthCodeView.isHidden = true
        
        Timer.scheduledTimer(timeInterval: 120.0, target: self, selector: #selector(timerForCodeSendingPassed), userInfo: nil, repeats: false)
        
        hideKeyboardWhenTappedAround()
        configureNavigationBar()
        addBackButtonAndTitleToNavigationBar(title: "After Call Prompt")
        
        self.wrongAuthCodeView.isHidden = true
        timerButtonOutlet.isHidden = true
        timerLabelOutlet.backgroundColor = Colors.Root.lightGrayColor
        sendCodeAgainLabelOutlet.backgroundColor = Colors.Root.lightGrayColor
        spaceLabelOutlet.backgroundColor = Colors.Root.lightGrayColor
        timerLabelOutlet.layer.cornerRadius = 2
        sendCodeAgainLabelOutlet.layer.cornerRadius = 2
        confirmButtonOutlet.layer.cornerRadius = 2
        confirmButtonOutlet.backgroundColor = Colors.Root.lightBlueColor
        timerButtonOutlet.layer.cornerRadius = 2
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        
        if RealmDataManager.getPhoneNumberFromRealm().count != 0 {
            let phoneCodeValue = String(describing: RealmDataManager.getDataFromCountries()[indexOfCountry].phoneCode!)
            personNumberLabelOutlet.text = "+" + phoneCodeValue + RealmDataManager.getPhoneNumberFromRealm()[0].phoneNumber!
        }
        
        if isTimerRunning == false {
            runTimer()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= 20
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += 20
            }
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        if seconds == 0 {
            timerButtonOutlet.isHidden = false
            timerButtonOutlet.backgroundColor = Colors.Root.lightBlueColor
            timerButtonOutlet.setTitle("Send code again", for: .normal)
            
            timerButtonOutlet.setTitleColor(.white, for: .normal)
            timer.invalidate()
        } else {
            seconds -= 1
            timerLabelOutlet.text = "(" + timeString(time: TimeInterval(seconds)) + ")"
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }

    
    @IBAction func confirmAuthCodeAction(_ sender: UIButton) {
//        let loadingAnimationStoryboard = UIStoryboard(name: "LoadingAnimation", bundle: Bundle.main)
//        let loadingAnimationController = loadingAnimationStoryboard.instantiateViewController(withIdentifier: "kLoadingAnimationViewController") as! LoadingAnimationViewController
        let phoneNumber = RealmDataManager.getPhoneNumberFromRealm()[0].phoneNumber!
        let authCode = textViewForCodeOutlet.text!
        let phoneCode = String(describing: RealmDataManager.getDataFromCountries()[indexOfCountry].phoneCode!)
        let getTokenObject = GetTokensRequest(phoneNumber: phoneNumber, phoneCode: phoneCode, authCode: authCode)
        getTokenObject.confirmAuthCode() { success in
            if success {
//                self.present(loadingAnimationController, animated: false, completion: nil)
                switch RealmDataManager.getTokensFromRealm()[0].userStatus! {
                case UserStatus.active.rawValue:
                    let MainScreenStoryboard = UIStoryboard(name: "MainScreen", bundle: Bundle.main)
                    let MainScreenController = MainScreenStoryboard.instantiateViewController(withIdentifier: "kMainScreenController") as! MainScreenController
                    MainScreenController.userIsRegistred = true
//                    loadingAnimationController.dismiss(animated: false, completion: nil)
                    self.navigationController?.pushViewController(MainScreenController, animated: true)
                case UserStatus.registrationInProgress.rawValue:
                    let RegistrationModuleStoryboard = UIStoryboard(name: "RegistrationModule", bundle: Bundle.main)
                    let RegistrationController = RegistrationModuleStoryboard.instantiateViewController(withIdentifier: "kFillRegistrationInfoViewController") as! FillRegistrationInfoViewController
                    RegistrationController.indexOfCountry = self.indexOfCountry
//                    loadingAnimationController.dismiss(animated: false, completion: nil)
                    self.navigationController?.pushViewController(RegistrationController, animated: true)
                default: return
                }
            } else {
                self.wrongAuthCodeView.isHidden = false
                Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.hideErrorView), userInfo: nil, repeats: false)
//                loadingAnimationController.dismiss(animated: false, completion: nil)
            }
        }
    }


    @IBAction func sendCodeAgainButtonTapped(_ sender: UIButton) {
        seconds = 120
        runTimer()
        timerButtonOutlet.isHidden = true
        let phoneCode = String(describing: RealmDataManager.getDataFromCountries()[indexOfCountry].phoneCode!)
        let getAuthCodeObject = GetAuthCode(number: RealmDataManager.getPhoneNumberFromRealm()[0].phoneNumber!, code: phoneCode)
        getAuthCodeObject.getAutCodeRequest()
        
    }

    deinit {
        timer.invalidate()
    }
    
    func timerForCodeSendingPassed() {
        delegate.timeToSentNewCode()
    }
    
    func hideErrorView() {
        wrongAuthCodeView.isHidden = true
    }
}
