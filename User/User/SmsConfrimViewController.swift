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
    
    @IBOutlet weak var personNumberLabelOutlet: UILabel!
    
    var seconds = 120
    var timer = Timer()
    var isTimerRunning = false
    
    let lightGray = UIColor(red: 230, green: 230, blue: 230, alpha: 1)
    let lightBlue = UIColor(red: 0, green: 128, blue: 255, alpha: 1)
    
    let lightGrayColor = UIColor( red: CGFloat(230/255.0), green: CGFloat(230/255.0), blue: CGFloat(230/255.0), alpha: CGFloat(1.0) )
    let lightBluecolor = UIColor( red: CGFloat(0/255.0), green: CGFloat(128/255.0), blue: CGFloat(255/255.0), alpha: CGFloat(1.0) )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        timerButtonOutlet.isHidden = true
        timerLabelOutlet.backgroundColor = lightGrayColor
        sendCodeAgainLabelOutlet.backgroundColor = lightGrayColor
        spaceLabelOutlet.backgroundColor = lightGrayColor
        timerLabelOutlet.layer.cornerRadius = 2
        sendCodeAgainLabelOutlet.layer.cornerRadius = 2
        confirmButtonOutlet.layer.cornerRadius = 2
        timerButtonOutlet.layer.cornerRadius = 2
        if RealmDataManager.getPhoneNumberFromRealm().count != 0 {
            personNumberLabelOutlet.text = RealmDataManager.getPhoneNumberFromRealm()[0].phoneNumber!
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
    @IBAction func sendCodeAgainButtonTapped(_ sender: UIButton) {
        
        seconds = 120
        runTimer()
        timerButtonOutlet.isHidden = true
        print("send code again")
    }
    
    deinit {
        timer.invalidate()
    }
}
