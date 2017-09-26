//
//  EditReminderViewController.swift
//  User
//
//  Created by User on 9/26/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import RealmSwift

class EditReminderViewController: UIViewController, CalendarPopupViewControllerDelegate, TimePopupViewControllerDelegate {
    
    
    @IBOutlet weak var saveButtonOutlet: UIButton!
    
    @IBOutlet weak var textFieldOutlet: UITextField!
    
    
    @IBOutlet weak var weekCheckboxOutlet: UIImageView!
    
    
    @IBOutlet weak var week2CheckboxOutlet: UIImageView!
    
    
    @IBOutlet weak var week3CheckboxOutlet: UIImageView!
    
    @IBOutlet weak var week4CheckboxOutlet: UIImageView!
    
    @IBOutlet weak var monthCheckboxOutlet: UIImageView!
    
    
    
    @IBOutlet weak var dayAndMonthDateOutlet: UILabel!
    
    
    @IBOutlet weak var minutesAndHoursDateOutlet: UILabel!
    
    
    @IBOutlet weak var reminderNameViewOutlet: UIView!
    
    @IBOutlet weak var reminderNameLabelOutlet: UILabel!
    
    @IBOutlet weak var grayLineUnderTextFieldOutlet: UIView!
    
    @IBOutlet weak var enterMedicineNameTextOutlet: UILabel!
    
    var weekReminderCheckButtonTapped = false
    var week2ReminderCheckButtonTapped = false
    var week3ReminderCheckButtonTapped = false
    var week4ReminderCheckButtonTapped = false
    var monthReminderCheckButtonTapped = false
    
    var reminderIndex = -1
    var reminderObjectFromRealm = ReminderModel()
    
    var checkboxesCheckedArray = [Bool]()
    
    var delegate: EditReminderViewControllerDelegate!
    
    var ifCheckBoxChanged = false
    
    let lightBluecolor = UIColor(red: CGFloat(0/255.0), green: CGFloat(128/255.0), blue: CGFloat(255/255.0), alpha: CGFloat(1.0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButtonOutlet.layer.cornerRadius = 2
        saveButtonOutlet.backgroundColor = lightBluecolor
        
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        backButton.setTitle("", for: .normal)
        
        backButton.setBackgroundImage(UIImage(named: "backButtonImage"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        
        let backButtonBarButton = UIBarButtonItem(customView: backButton)
        
        let titleLabel = UILabel()
        titleLabel.text = "Reminder details"
        titleLabel.textColor = .white
        titleLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        let titleLabelBarButton = UIBarButtonItem(customView: titleLabel)
        
        navigationItem.setLeftBarButtonItems([backButtonBarButton, titleLabelBarButton], animated: true)
        
        reminderNameViewOutlet.layer.borderWidth = 0.5
        reminderNameViewOutlet.layer.borderColor = UIColor.black.cgColor
        
        reminderObjectFromRealm = Array(RealmDataManager.getRemindersFromRealm())[reminderIndex]
        
        checkboxesCheckedArray.append(weekReminderCheckButtonTapped)
        checkboxesCheckedArray.append(week2ReminderCheckButtonTapped)
        checkboxesCheckedArray.append(week3ReminderCheckButtonTapped)
        checkboxesCheckedArray.append(week4ReminderCheckButtonTapped)
        checkboxesCheckedArray.append(monthReminderCheckButtonTapped)
        
        checkboxesCheckedArray[reminderObjectFromRealm.checkBoxIndex] = true
        switch reminderObjectFromRealm.checkBoxIndex {
        case 0:
            weekCheckboxOutlet.image = UIImage(named: "checkBoxChecked.png")
        case 1:
            week2CheckboxOutlet.image = UIImage(named: "checkBoxChecked.png")
        case 2:
            week3CheckboxOutlet.image = UIImage(named: "checkBoxChecked.png")
        case 3:
            week4CheckboxOutlet.image = UIImage(named: "checkBoxChecked.png")
        case 4:
            monthCheckboxOutlet.image = UIImage(named: "checkBoxChecked.png")
        default:
            break
        }
        dayAndMonthDateOutlet.text = reminderObjectFromRealm.dateTimeDaysAndYears
        minutesAndHoursDateOutlet.text = reminderObjectFromRealm.dateTimeHoursAndMinutes
        reminderNameLabelOutlet.text = reminderObjectFromRealm.medicineName
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func weekReminderButtonTapped(_ sender: UIButton) {
        if weekReminderCheckButtonTapped == false {
            weekCheckboxOutlet.image = UIImage(named: "checkBoxChecked.png")
            weekReminderCheckButtonTapped = true
            week2CheckboxOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            week3CheckboxOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            week4CheckboxOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            monthCheckboxOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            week2ReminderCheckButtonTapped = false
            week3ReminderCheckButtonTapped = false
            week4ReminderCheckButtonTapped = false
            monthReminderCheckButtonTapped = false
            ifCheckBoxChanged = true
        }
    }
    
    @IBAction func week2ReminderButtonTapped(_ sender: UIButton) {
        if week2ReminderCheckButtonTapped == false {
            week2CheckboxOutlet.image = UIImage(named: "checkBoxChecked.png")
            week2ReminderCheckButtonTapped = true
            weekCheckboxOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            week3CheckboxOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            week4CheckboxOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            monthCheckboxOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            weekReminderCheckButtonTapped = false
            week3ReminderCheckButtonTapped = false
            week4ReminderCheckButtonTapped = false
            monthReminderCheckButtonTapped = false
            ifCheckBoxChanged = true
        }
    }
    @IBAction func week3ReminderButtonTapped(_ sender: UIButton) {
        if week3ReminderCheckButtonTapped == false {
            week3CheckboxOutlet.image = UIImage(named: "checkBoxChecked.png")
            week3ReminderCheckButtonTapped = true
            week2CheckboxOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            weekCheckboxOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            week4CheckboxOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            monthCheckboxOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            week2ReminderCheckButtonTapped = false
            weekReminderCheckButtonTapped = false
            week4ReminderCheckButtonTapped = false
            monthReminderCheckButtonTapped = false
            ifCheckBoxChanged = true
        }
    }
    
    @IBAction func week4RemiderButtonTapped(_ sender: UIButton) {
        if week4ReminderCheckButtonTapped == false {
            week4CheckboxOutlet.image = UIImage(named: "checkBoxChecked.png")
            week4ReminderCheckButtonTapped = true
            week2CheckboxOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            week3CheckboxOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            weekCheckboxOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            monthCheckboxOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            week2ReminderCheckButtonTapped = false
            week3ReminderCheckButtonTapped = false
            weekReminderCheckButtonTapped = false
            monthReminderCheckButtonTapped = false
            ifCheckBoxChanged = true
        }
    }
    
    @IBAction func monthReminderButtonTapped(_ sender: UIButton) {
        if monthReminderCheckButtonTapped == false {
            monthCheckboxOutlet.image = UIImage(named: "checkBoxChecked.png")
            monthReminderCheckButtonTapped = true
            weekCheckboxOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            week2CheckboxOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            week3CheckboxOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            week4CheckboxOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            week2ReminderCheckButtonTapped = false
            week3ReminderCheckButtonTapped = false
            week4ReminderCheckButtonTapped = false
            weekReminderCheckButtonTapped = false
            ifCheckBoxChanged = true
        }
    }
    
    
    @IBAction func dayAndMonthPopupButtonTapped(_ sender: UIButton) {
        let settingsStoryboard = UIStoryboard(name: "RefillsAndReminders", bundle: nil)
        let calendarPopupViewController = settingsStoryboard.instantiateViewController(withIdentifier: "kCalendarPopupViewController") as? CalendarPopupViewController
        calendarPopupViewController?.delegate = self
        
        present(calendarPopupViewController!, animated: true, completion: nil)
    }
    
    
    @IBAction func hoursAndMinutesPopupButtonTapped(_ sender: UIButton) {
        let settingsStoryboard = UIStoryboard(name: "RefillsAndReminders", bundle: nil)
        let timePopupViewController = settingsStoryboard.instantiateViewController(withIdentifier: "kTimePopupViewController") as? TimePopupViewController
        timePopupViewController?.delegate = self
        
        present(timePopupViewController!, animated: true, completion: nil)
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let realmObjectToSave = Array(RealmDataManager.getRemindersFromRealm())[reminderIndex]
        
        let realm = try! Realm()
        try! realm.write {
            if textFieldOutlet.text != "" {
                realmObjectToSave.medicineName = textFieldOutlet.text
            } 
            if ifCheckBoxChanged {
                realmObjectToSave.checkBoxIndex = getTrueCheckIndex(weekCheckboxBool: weekReminderCheckButtonTapped, week2CheckboxBool: week2ReminderCheckButtonTapped, week3CheckboxBool: week3ReminderCheckButtonTapped, week4CheckboxBool: week4ReminderCheckButtonTapped, monthCheckboxBool: monthReminderCheckButtonTapped)!
            }
            realmObjectToSave.dateTimeHoursAndMinutes = minutesAndHoursDateOutlet.text
            realmObjectToSave.dateTimeDaysAndYears = dayAndMonthDateOutlet.text
        }
        
        let transition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        self.navigationController!.view.layer.add(transition, forKey: nil)
        
        delegate.reloadTableAfterEditing()
        
        navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func deleteReminderNameTapped(_ sender: UIButton) {
        reminderNameViewOutlet.isHidden = true
    }
    
    func backButtonTapped(_ sender: UIButton) {
        let transition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        self.navigationController!.view.layer.add(transition, forKey: nil)
        
        navigationController?.popViewController(animated: false)
    }
    
    func trasferDataTime(data: Date) {
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: data)
        let minutes = calendar.component(.minute, from: data)
        if minutes < 10 {
            minutesAndHoursDateOutlet.text = String(hour) + ":" + "0" + String(minutes)
        } else {
            minutesAndHoursDateOutlet.text = String(hour) + ":" + String(minutes)
        }
    }
    
    func transferData(data: Date) {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd.MM.yyyy"
        dayAndMonthDateOutlet.text = formatter.string(from: data)
    }
    
    func getTrueCheckIndex(weekCheckboxBool: Bool, week2CheckboxBool: Bool, week3CheckboxBool: Bool, week4CheckboxBool: Bool, monthCheckboxBool: Bool) -> Int? {
        var checksBoolArray = [Bool]()
        checksBoolArray.append(weekCheckboxBool)
        checksBoolArray.append(week2CheckboxBool)
        checksBoolArray.append(week3CheckboxBool)
        checksBoolArray.append(week4CheckboxBool)
        checksBoolArray.append(monthCheckboxBool)
        for boolean in checksBoolArray {
            if boolean == true {
                return checksBoolArray.index(of: boolean)
            }
        }
        return nil
    }
}
