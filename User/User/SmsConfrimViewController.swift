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


class SmsConfrimViewController: UIViewController {
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
    
    
    let lightGray = UIColor(red: 230, green: 230, blue: 230, alpha: 1)
    let lightBlue = UIColor(red: 0, green: 128, blue: 255, alpha: 1)
    
    let lightGrayColor = UIColor( red: CGFloat(230/255.0), green: CGFloat(230/255.0), blue: CGFloat(230/255.0), alpha: CGFloat(1.0) )
    let lightBluecolor = UIColor( red: CGFloat(0/255.0), green: CGFloat(128/255.0), blue: CGFloat(255/255.0), alpha: CGFloat(1.0) )
    
    let realm = try! Realm()
    
    var delegate: SmsConfrimViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wrongAuthCodeView.isHidden = true
        
        Timer.scheduledTimer(timeInterval: 120.0, target: self, selector: #selector(timerForCodeSendingPassed), userInfo: nil, repeats: false)
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.4, green: 0.8, blue: 0.7, alpha: 1)
        
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        navigationController?.navigationBar.layer.shadowRadius = 4.0
        navigationController?.navigationBar.layer.shadowOpacity = 0.5
        navigationController?.navigationBar.layer.masksToBounds = false
        
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        backButton.setTitle("", for: .normal)
        
        backButton.setBackgroundImage(UIImage(named: "backButtonImage"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        
        let backButtonBarButton = UIBarButtonItem(customView: backButton)
        
        let titleLabel = UILabel()
        titleLabel.text = "After Call Prompt"
        titleLabel.textColor = .white
        titleLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        let titleLabelBarButton = UIBarButtonItem(customView: titleLabel)
        
        navigationItem.setLeftBarButtonItems([backButtonBarButton, titleLabelBarButton], animated: true)
        
        print(indexOfCountry)
        
        self.wrongAuthCodeView.isHidden = true
        timerButtonOutlet.isHidden = true
        timerLabelOutlet.backgroundColor = lightGrayColor
        sendCodeAgainLabelOutlet.backgroundColor = lightGrayColor
        spaceLabelOutlet.backgroundColor = lightGrayColor
        timerLabelOutlet.layer.cornerRadius = 2
        sendCodeAgainLabelOutlet.layer.cornerRadius = 2
        confirmButtonOutlet.layer.cornerRadius = 2
        timerButtonOutlet.layer.cornerRadius = 2
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
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        if seconds == 0 {
            timerButtonOutlet.isHidden = false
            timerButtonOutlet.backgroundColor = lightBluecolor
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
        let phoneNumber = RealmDataManager.getPhoneNumberFromRealm()[0].phoneNumber!
        let authCode = textViewForCodeOutlet.text!
        let phoneCode = String(describing: RealmDataManager.getDataFromCountries()[indexOfCountry].phoneCode!)
        let getTokenObject = GetTokensRequest(phoneNumber: phoneNumber, phoneCode: phoneCode, authCode: authCode)
        getTokenObject.confirmAuthCode() { success in
            if success {
                switch RealmDataManager.getTokensFromRealm()[0].userStatus! {
                case UserStatus.active.rawValue:
                    let MainScreenStoryboard = UIStoryboard(name: "MainScreen", bundle: Bundle.main)
                    let MainScreenController = MainScreenStoryboard.instantiateViewController(withIdentifier: "kMainScreenController") as! MainScreenController
                    MainScreenController.userIsRegistred = true
                    self.navigationController?.pushViewController(MainScreenController, animated: true)
                case UserStatus.registrationInProgress.rawValue:
                    let RegistrationModuleStoryboard = UIStoryboard(name: "RegistrationModule", bundle: Bundle.main)
                    let RegistrationController = RegistrationModuleStoryboard.instantiateViewController(withIdentifier: "kFillRegistrationInfoViewController") as! FillRegistrationInfoViewController
                    RegistrationController.indexOfCountry = self.indexOfCountry
                    self.navigationController?.pushViewController(RegistrationController, animated: true)
                default: return
                }
            } else {
                self.wrongAuthCodeView.isHidden = false
                Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.hideErrorView), userInfo: nil, repeats: false)
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
    
    func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
    
    func timerForCodeSendingPassed() {
        delegate.timeToSentNewCode()
    }
    
    func hideErrorView() {
        wrongAuthCodeView.isHidden = true
    }
}
