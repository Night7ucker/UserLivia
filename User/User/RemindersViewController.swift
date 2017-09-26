//
//  RemindersModule.swift
//  User
//
//  Created by User on 9/25/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import RealmSwift

protocol AddReminderViewControllerProtocol: class {
    func reloadTable()
}

protocol EditReminderViewControllerDelegate: class {
    func reloadTableAfterEditing()
}

class RemindersViewController: UIViewController, AddReminderViewControllerProtocol, EditReminderViewControllerDelegate {
    
    @IBOutlet weak var remindersTableViewOutlet: UITableView!
    
    var arrayOfReminders = [ReminderModel]()
    
    var tableViewIsHidden = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.4, green: 0.8, blue: 0.7, alpha: 1)
        
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        navigationController?.navigationBar.layer.shadowRadius = 4.0
        navigationController?.navigationBar.layer.shadowOpacity = 0.5
        navigationController?.navigationBar.layer.masksToBounds = false
        
        remindersTableViewOutlet.delegate = self
        remindersTableViewOutlet.dataSource = self
        
        remindersTableViewOutlet.isHidden = true
        
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        backButton.setTitle("", for: .normal)
        
        backButton.setBackgroundImage(UIImage(named: "backButtonImage"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        
        let backButtonBarButton = UIBarButtonItem(customView: backButton)
        
        let titleLabel = UILabel()
        titleLabel.text = "Reminders"
        titleLabel.textColor = .white
        titleLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        let titleLabelBarButton = UIBarButtonItem(customView: titleLabel)
        
        navigationItem.setLeftBarButtonItems([backButtonBarButton, titleLabelBarButton], animated: true)
        
        let addReminderButton = UIButton(type: .system)
        addReminderButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        addReminderButton.setTitle("+", for: .normal)
        addReminderButton.titleLabel?.font = UIFont(name: "Arial", size: 45)
        addReminderButton.titleLabel?.font = UIFont.systemFont(ofSize: 34, weight: UIFontWeightThin)
        addReminderButton.setTitleColor(.white, for: .normal)
        addReminderButton.titleEdgeInsets = UIEdgeInsetsMake(5, 25, 0, 0)
        addReminderButton.addTarget(self, action: #selector(addTapped(_ :)), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addReminderButton)
        
        arrayOfReminders = Array(RealmDataManager.getRemindersFromRealm())
        if arrayOfReminders.count != 0 {
            tableViewIsHidden = false
            remindersTableViewOutlet.isHidden = false
        }
        
        if arrayOfReminders.count == 0 {
            remindersTableViewOutlet.separatorStyle = .none
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addTapped(_ sender: UIButton) {
        let transition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        self.navigationController!.view.layer.add(transition, forKey: nil)
        
        let refillsAndRemindersStoryboard = UIStoryboard(name: "RefillsAndReminders", bundle: nil)
        let addReminderViewController = refillsAndRemindersStoryboard.instantiateViewController(withIdentifier: "kAddReminderViewController") as? AddReminderViewController
        addReminderViewController?.delegate = self
        navigationController?.pushViewController(addReminderViewController!, animated: false)
    }
    
    func reloadTable() {
        arrayOfReminders = Array(RealmDataManager.getRemindersFromRealm())
        remindersTableViewOutlet.reloadData()
        tableViewIsHidden = false
        remindersTableViewOutlet.isHidden = false
        remindersTableViewOutlet.separatorStyle = .singleLine
    }
}

extension RemindersViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "ACTIVE:"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = UIView()
        
        sectionHeaderView.backgroundColor = UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 0.05)
        
        let sectionHeaderLabel = UILabel()
        
        sectionHeaderLabel.text = "ACTIVE:"
        sectionHeaderLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.4)
        sectionHeaderLabel.font = UIFont(name: "Arial", size: 13)
        sectionHeaderLabel.frame = CGRect(x: 15, y: 5, width: 100, height: 20)
        sectionHeaderView.addSubview(sectionHeaderLabel)
        
        
        return sectionHeaderView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfReminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableViewIsHidden == false {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath) as! ReminderTableViewCell
            
            cell.medicineNameLabelOutlet.text = arrayOfReminders[indexPath.row].medicineName
            cell.reminderDateLabelOutlet.text = arrayOfReminders[indexPath.row].dateTimeDaysAndYears! + " " + arrayOfReminders[indexPath.row].dateTimeHoursAndMinutes!
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let realm = try! Realm()
            try! realm.write {
                realm.delete(RealmDataManager.getRemindersFromRealm()[indexPath.row])
            }
            arrayOfReminders = Array(RealmDataManager.getRemindersFromRealm())
            tableView.deleteRows(at: [indexPath], with: .automatic)
            if arrayOfReminders.count == 0 {
                remindersTableViewOutlet.separatorStyle = .none
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        self.navigationController!.view.layer.add(transition, forKey: nil)
        
        let remindersStoryboard = UIStoryboard(name: "RefillsAndReminders", bundle: nil)
        let editReminderViewController = remindersStoryboard.instantiateViewController(withIdentifier: "kEditReminderViewController") as? EditReminderViewController
        editReminderViewController?.reminderIndex = indexPath.row
        editReminderViewController?.delegate = self
        navigationController?.pushViewController(editReminderViewController!, animated: false)
    }
    
    func reloadTableAfterEditing() {
        remindersTableViewOutlet.reloadData()
    }
    
    func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
    
}

extension RemindersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

