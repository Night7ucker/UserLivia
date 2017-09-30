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

class AddReminderViewController: RootViewController, CalendarPopupViewControllerDelegate, TimePopupViewControllerDelegate {
    
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
    
    var weekReminderCheckButtonTapped = true
    var week2ReminderCheckButtonTapped = false
    var week3ReminderCheckButtonTapped = false
    var week4ReminderCheckButtonTapped = false
    var monthReminderCheckButtonTapped = false
    
    var dayDateBeforeFormating = String()
    var hourDateBeforeFormating = String()
    
    var delegate: AddReminderViewControllerProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        addBackButtonAndTitleToNavigationBar(title: "Add reminder")
        
        viewWithDateOutlet.layer.borderWidth = 0.5
        saveButtonOutlet.backgroundColor = Colors.Root.lightBlueColor
        saveButtonOutlet.layer.cornerRadius = 2
        
        poupErrorViewOutlet.isHidden = true
        
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
        
        formatter.dateFormat = "yyyy-MM-dd"
        dayDateBeforeFormating = formatter.string(from: data)
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
        let minute = calendar.component(.minute, from: data)
        let second = calendar.component(.second, from: data)
        
        var hours = String(hour)
        if hour < 10 {
            hours = "0" + String(hour)
        }
        var minutes = String(minute)
        if minute < 10 {
            minutes = "0" + String(minute)
        }
        var seconds = String(second)
        if second < 10 {
            seconds = "0" + String(second)
        }
        hourDateBeforeFormating = hours + ":" + minutes + ":" + seconds + "+03:00"
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
                return checkBoxArray.index(of: boolean)! + 1
            }
        }
        return nil
    }
    
    @IBAction func saveReminderButtonTapped(_ sender: UIButton) {
        if dayDateBeforeFormating == "" {
            let date = Date()
            let calendar = Calendar.current
            
            let year = calendar.component(.year, from: date)
            let month = calendar.component(.month, from: date)
            let day = calendar.component(.day, from: date)
            
            var years = String(year)
            if year < 10 {
                years = "0" + String(year)
            }
            var months = String(month)
            if month < 10 {
                months = "0" + String(month)
            }
            var days = String(day)
            if day < 10 {
                days = "0" + String(day)
            }
            dayDateBeforeFormating = years + "-" + months + "-" + days
        }
        if hourDateBeforeFormating == "" {
            hourDateBeforeFormating = String(describing: Calendar.current)
            let date = Date()
            let calendar = Calendar.current
            
            let hour = calendar.component(.hour, from: date)
            let minute = calendar.component(.minute, from: date)
            let second = calendar.component(.second, from: date)
            
            var hours = String(hour)
            if hour < 10 {
                hours = "0" + String(hour)
            }
            var minutes = String(minute)
            if minute < 10 {
                minutes = "0" + String(minute)
            }
            var seconds = String(second)
            if second < 10 {
                seconds = "0" + String(second)
            }
            
            hourDateBeforeFormating = hours + ":" + minutes + ":" + seconds + "+03:00"
        }
        let finalDateBeforeFromating = dayDateBeforeFormating + "T" + hourDateBeforeFormating
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
        reminderModelObject.dateForRequest = finalDateBeforeFromating
        let realm = try! Realm()
        RealmDataManager.writeIntoRealm(object: reminderModelObject, realm: realm)
        delegate.reloadTable()
        ReminderRequests.addReminder { success in
            
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func dismissAlert() {
        poupErrorViewOutlet.isHidden = true
    }
}
