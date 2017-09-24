//
//  SmsConfrimViewController.swift
//  User
//
//  Created by User on 9/23/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//
// timer, constraints

//RealmDataManager.getPhoneNumberFromRealm()[0].phoneNumber! get phone number

import UIKit
import RealmSwift

class SmsConfrimViewController: UIViewController {
    @IBOutlet weak var textViewForCodeOutlet: UITextField!
    @IBOutlet weak var confirmButtonOutlet: UIButton!
    
    @IBOutlet weak var timerButtonOutlet: UIButton!
    @IBOutlet weak var spaceLabelOutlet: UILabel!
    
    @IBOutlet weak var timerLabelOutlet: UILabel!
    
    @IBOutlet weak var sendCodeAgainLabelOutlet: UILabel!
    
    
    var seconds = 2
    var timer = Timer()
    var isTimerRunning = false
    
    let lightGray = UIColor(red: 230, green: 230, blue: 230, alpha: 1)
    let lightBlue = UIColor(red: 0, green: 128, blue: 255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        timerButtonOutlet.isHidden = true
        timerLabelOutlet.backgroundColor = lightGray
        sendCodeAgainLabelOutlet.backgroundColor = lightGray
        spaceLabelOutlet.backgroundColor = lightGray
        timerLabelOutlet.layer.cornerRadius = 2
        sendCodeAgainLabelOutlet.layer.cornerRadius = 2
        confirmButtonOutlet.layer.cornerRadius = 2
        timerButtonOutlet.layer.cornerRadius = 2
        
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
            timerButtonOutlet.backgroundColor = .white
            timerButtonOutlet.setTitle("Send code again", for: .normal)
            
            
            
            timerButtonOutlet.setTitleColor(lightBlue, for: .normal)
        }
        seconds -= 1
        timerLabelOutlet.text = "(" + timeString(time: TimeInterval(seconds)) + ")"
        
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    @IBAction func sendCodeAgainButtonTapped(_ sender: UIButton) {
        print("send code again")
    }
}

extension SmsConfrimViewController {
    
    
}
