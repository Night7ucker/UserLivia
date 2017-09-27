//
//  AddReminderViewController.swift
//  User
//
//  Created by User on 9/25/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import RealmSwift

protocol CalendarPopupViewControllerDelegate: class {
    func transferData(data: Date)
}

protocol TimePopupViewControllerDelegate: class {
    func trasferDataTime(data: Date)
}

class AddReminderViewController: UIViewController, CalendarPopupViewControllerDelegate, TimePopupViewControllerDelegate {
    
    @IBOutlet weak var viewWithDateOutlet: UIView!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    
    @IBOutlet weak var checkImageWeekOutlet: UIImageView!
    
    
    @IBOutlet weak var checkImage2WeekOutlet: UIImageView!
    
    @IBOutlet weak var checkImage3WeekOutlet: UIImageView!
    
    @IBOutlet weak var checkImage4WeekOutlet: UIImageView!
    
    @IBOutlet weak var checkImageMonthOutlet: UIImageView!
    
    
    @IBOutlet weak var dateLabelOutlet: UILabel!
    
    @IBOutlet weak var timeHoursLabelOutlet: UILabel!
    
    @IBOutlet weak var medicineNameTextFieldOutlet: UITextField!
    
    
    @IBOutlet weak var poupErrorViewOutlet: UIView!
    
    
    let lightBlueColor = UIColor(red: CGFloat(0/255.0), green: CGFloat(128/255.0), blue: CGFloat(255/255.0), alpha: CGFloat(1.0))
    
    var weekReminderCheckButtonTapped = true
    var week2ReminderCheckButtonTapped = false
    var week3ReminderCheckButtonTapped = false
    var week4ReminderCheckButtonTapped = false
    var monthReminderCheckButtonTapped = false
    
    var delegate: AddReminderViewControllerProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.4, green: 0.8, blue: 0.7, alpha: 1)
        
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        navigationController?.navigationBar.layer.shadowRadius = 4.0
        navigationController?.navigationBar.layer.shadowOpacity = 0.5
        navigationController?.navigationBar.layer.masksToBounds = false
        
        viewWithDateOutlet.layer.borderWidth = 0.5
        saveButtonOutlet.backgroundColor = lightBlueColor
        saveButtonOutlet.layer.cornerRadius = 2
        
        poupErrorViewOutlet.isHidden = true
        
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        backButton.setTitle("", for: .normal)
        
        backButton.setBackgroundImage(UIImage(named: "backButtonImage"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        
        let backButtonBarButton = UIBarButtonItem(customView: backButton)
        
        let titleLabel = UILabel()
        titleLabel.text = "Add reminder"
        titleLabel.textColor = .white
        titleLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        let titleLabelBarButton = UIBarButtonItem(customView: titleLabel)
        
        navigationItem.setLeftBarButtonItems([backButtonBarButton, titleLabelBarButton], animated: true)
        
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateLabelOutlet.text = formatter.string(from: currentDate)
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentDate)
        let minutes = calendar.component(.minute, from: currentDate)
        if minutes < 10 {
            timeHoursLabelOutlet.text = String(hour) + ":" + "0" + String(minutes)
        } else {
            timeHoursLabelOutlet.text = String(hour) + ":" + String(minutes)
        }
        
        checkImageWeekOutlet.image = UIImage(named: "checkBoxChecked.png")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backButtonTapped(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        self.navigationController!.view.layer.add(transition, forKey: nil)
        
        navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func weekReminderCheckButtonTapped(_ sender: UIButton) {
        if weekReminderCheckButtonTapped == false {
            checkImageWeekOutlet.image = UIImage(named: "checkBoxChecked.png")
            weekReminderCheckButtonTapped = true
            checkImage2WeekOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            checkImage3WeekOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            checkImage4WeekOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            checkImageMonthOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            week2ReminderCheckButtonTapped = false
            week3ReminderCheckButtonTapped = false
            week4ReminderCheckButtonTapped = false
            monthReminderCheckButtonTapped = false
        }
    }
    
    @IBAction func week2ReminderCheckButtonTapped(_ sender: UIButton) {
        if week2ReminderCheckButtonTapped == false {
            checkImage2WeekOutlet.image = UIImage(named: "checkBoxChecked.png")
            week2ReminderCheckButtonTapped = true
            checkImageWeekOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            checkImage3WeekOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            checkImage4WeekOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            checkImageMonthOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            weekReminderCheckButtonTapped = false
            week3ReminderCheckButtonTapped = false
            week4ReminderCheckButtonTapped = false
            monthReminderCheckButtonTapped = false
        }
    }
    
    
    @IBAction func week3ReminderCheckButtonTapped(_ sender: UIButton) {
        if week3ReminderCheckButtonTapped == false {
            checkImage3WeekOutlet.image = UIImage(named: "checkBoxChecked.png")
            week3ReminderCheckButtonTapped = true
            checkImage2WeekOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            checkImageWeekOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            checkImage4WeekOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            checkImageMonthOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            week2ReminderCheckButtonTapped = false
            weekReminderCheckButtonTapped = false
            week4ReminderCheckButtonTapped = false
            monthReminderCheckButtonTapped = false
        }
        
    }
    
    
    @IBAction func week4ReminderCheckButtonTapped(_ sender: UIButton) {
        if week4ReminderCheckButtonTapped == false {
            checkImage4WeekOutlet.image = UIImage(named: "checkBoxChecked.png")
            week4ReminderCheckButtonTapped = true
            checkImage2WeekOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            checkImage3WeekOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            checkImageWeekOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            checkImageMonthOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            week2ReminderCheckButtonTapped = false
            week3ReminderCheckButtonTapped = false
            weekReminderCheckButtonTapped = false
            monthReminderCheckButtonTapped = false
        }
        
    }
    
    
    
    
    @IBAction func monthReminderCheckButtonTapped(_ sender: UIButton) {
        if monthReminderCheckButtonTapped == false {
            checkImageMonthOutlet.image = UIImage(named: "checkBoxChecked.png")
            monthReminderCheckButtonTapped = true
            checkImage2WeekOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            checkImage3WeekOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            checkImage4WeekOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            checkImageWeekOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            week2ReminderCheckButtonTapped = false
            week3ReminderCheckButtonTapped = false
            week4ReminderCheckButtonTapped = false
            weekReminderCheckButtonTapped = false
        }
        
    }
    
    @IBAction func calendarPopupButtonTapped(_ sender: UIButton) {
        let settingsStoryboard = UIStoryboard(name: "RefillsAndReminders", bundle: nil)
        let calendarPopupViewController = settingsStoryboard.instantiateViewController(withIdentifier: "kCalendarPopupViewController") as? CalendarPopupViewController
        calendarPopupViewController?.delegate = self
        
        present(calendarPopupViewController!, animated: true, completion: nil)
    }
    
    func transferData(data: Date) {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd.MM.yyyy"
        dateLabelOutlet.text = formatter.string(from: data)
    }
    
    
    @IBAction func timePopupButtonTapped(_ sender: UIButton) {
        let settingsStoryboard = UIStoryboard(name: "RefillsAndReminders", bundle: nil)
        let timePopupViewController = settingsStoryboard.instantiateViewController(withIdentifier: "kTimePopupViewController") as? TimePopupViewController
        timePopupViewController?.delegate = self
        
        present(timePopupViewController!, animated: true, completion: nil)
    }
    
    func trasferDataTime(data: Date) {
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: data)
        let minutes = calendar.component(.minute, from: data)
        if minutes < 10 {
            timeHoursLabelOutlet.text = String(hour) + ":" + "0" + String(minutes)
        } else {
            timeHoursLabelOutlet.text = String(hour) + ":" + String(minutes)
        }
    }
    
    func getTrueCheckIndex(week1Checkbox: Bool, week2Checkbox: Bool, week3Checkbox: Bool, week4Checkbox: Bool, monthCheckbox: Bool) -> Int? {
        var checkBoxArray = [Bool]()
        checkBoxArray.append(week1Checkbox)
        checkBoxArray.append(week2Checkbox)
        checkBoxArray.append(week3Checkbox)
        checkBoxArray.append(week4Checkbox)
        checkBoxArray.append(monthCheckbox)
        for boolean in checkBoxArray {
            if boolean == true {
                return checkBoxArray.index(of: boolean)
            }
        }
        return nil
    }
    
    @IBAction func saveReminderButtonTapped(_ sender: UIButton) {
        if medicineNameTextFieldOutlet.text == "" {
            poupErrorViewOutlet.isHidden = false
            Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(dismissAlert), userInfo: nil, repeats: false)
            return
        }
        let checkBoxIndex = getTrueCheckIndex(week1Checkbox: weekReminderCheckButtonTapped, week2Checkbox: week2ReminderCheckButtonTapped, week3Checkbox: week3ReminderCheckButtonTapped, week4Checkbox: week4ReminderCheckButtonTapped, monthCheckbox: monthReminderCheckButtonTapped)
        let reminderModelObject = ReminderModel()
        if checkBoxIndex != nil {
            reminderModelObject.checkBoxIndex = checkBoxIndex!
        }
        reminderModelObject.dateTimeDaysAndYears = dateLabelOutlet.text
        reminderModelObject.dateTimeHoursAndMinutes = timeHoursLabelOutlet.text
        reminderModelObject.medicineName = medicineNameTextFieldOutlet.text
        let realm = try! Realm()
        RealmDataManager.writeIntoRealm(object: reminderModelObject, realm: realm)
        delegate.reloadTable()
        
        navigationController?.popViewController(animated: true)
    }
    
    func dismissAlert() {
        poupErrorViewOutlet.isHidden = true
    }
}

//class PaddingLabel: UILabel {
//
//    override func drawText(in rect: CGRect) {
//        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
//        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
//    }
//
//    override var intrinsicContentSize: CGSize {
//        get {
//            var contentSize = super.intrinsicContentSize
//            contentSize.height += 10 + 10
//            contentSize.width += 5 + 5
//            return contentSize
//        }
//    }
//}
