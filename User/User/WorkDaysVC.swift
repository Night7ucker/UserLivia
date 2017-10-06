//
//  WorkDaysVC.swift
//  User
//
//  Created by User on 10/5/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import RealmSwift

class WorkDaysVC: RootViewController {

    @IBOutlet weak var workDaysTableViewOutlet: UITableView!
    
    var arrayOfDays: Results<WorkingHour>? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        if RealmDataManager.getWorkingHoursModel().count != 0 {
            try! realm.write {
                realm.delete(RealmDataManager.getWorkingHoursModel())
            }
        }

        configureNavigationBar()
        addBackButtonAndTitleToNavigationBar(title: "Work time")
        
        workDaysTableViewOutlet.delegate = self
        workDaysTableViewOutlet.dataSource = self
        workDaysTableViewOutlet.isHidden = true
        
        WorkingHoursRequest.getWorkingHoursFor(pharmacyID: RealmDataManager.getOrderDrugsDescriptionModel()[0].pId!) { success in
            if success {
                self.arrayOfDays = RealmDataManager.getWorkingHoursModel()
                self.workDaysTableViewOutlet.reloadData()
                self.workDaysTableViewOutlet.isHidden = false
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func formStartWorkEndWork(index: Int) -> (String, String) {
        let startWorkHours = String(Int((arrayOfDays?[index].startWork)!)! / 60)
        var startWorkMinutes = String(Int((arrayOfDays?[index].startWork)!)! % 60)
        if startWorkMinutes == "0" {
            startWorkMinutes += "0"
        }
        let startWorkTime = startWorkHours + ":" + startWorkMinutes
        
        let endWorkHours = String(Int((arrayOfDays?[index].endWork)!)! / 60)
        var endWorkMinutes = String(Int((arrayOfDays?[index].endWork)!)! % 60)
        if endWorkMinutes == "0" {
            endWorkMinutes += "0"
        }
        let endWorkTime = endWorkHours + ":" + endWorkMinutes
        
        return (startWorkTime, endWorkTime)
    }
    
    func formStartLaunchEndWork(index: Int) -> (String, String) {
        let startWorkHours = String(Int((arrayOfDays?[index].startLunch)!)! / 60)
        var startWorkMinutes = String(Int((arrayOfDays?[index].startLunch)!)! % 60)
        if startWorkMinutes == "0" {
            startWorkMinutes += "0"
        }
        let startWorkTime = startWorkHours + ":" + startWorkMinutes
        
        let endWorkHours = String(Int((arrayOfDays?[index].endLunch)!)! / 60)
        var endWorkMinutes = String(Int((arrayOfDays?[index].endLunch)!)! % 60)
        if endWorkMinutes == "0" {
            endWorkMinutes += "0"
        }
        let endWorkTime = endWorkHours + ":" + endWorkMinutes
        
        
        
        return (startWorkTime, endWorkTime)
    }

}

extension WorkDaysVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let workDaysCell = tableView.dequeueReusableCell(withIdentifier: "workDaysCell") as! WorkDaysCell
        
        if RealmDataManager.getWorkingHoursModel().count != 0 {
            switch indexPath.row {
            case 0:
                if Int((arrayOfDays?[indexPath.row].dayType)!) == 0 {
                    workDaysCell.workDayBackgroundOutlet.image = #imageLiteral(resourceName: "workDayBackgroundGray")
                    workDaysCell.launchBreakLabelOutlet.isHidden = true
                    workDaysCell.workingTimeLabelOutlet.isHidden = true
                    workDaysCell.workingLabelOutlet.isHidden = true
                    workDaysCell.launchBreakTimeLabelOutlet.isHidden = true
                } else {
                    workDaysCell.workDayBackgroundOutlet.image = #imageLiteral(resourceName: "workDayBackgroundGreen")
                }
                workDaysCell.workingTimeLabelOutlet.text = formStartWorkEndWork(index: indexPath.row).0 + " - " + formStartWorkEndWork(index: indexPath.row).1
                workDaysCell.launchBreakTimeLabelOutlet.text = formStartLaunchEndWork(index: indexPath.row).0 + " - " + formStartLaunchEndWork(index: indexPath.row).1
                workDaysCell.workDayImageViewOutlet.image = UIImage(named: "monday")
            case 1:
                if Int((arrayOfDays?[indexPath.row].dayType)!) == 0 {
                    workDaysCell.workDayBackgroundOutlet.image = #imageLiteral(resourceName: "workDayBackgroundGray")
                    workDaysCell.launchBreakLabelOutlet.isHidden = true
                    workDaysCell.workingTimeLabelOutlet.isHidden = true
                    workDaysCell.workingLabelOutlet.isHidden = true
                    workDaysCell.launchBreakTimeLabelOutlet.isHidden = true
                } else {
                    workDaysCell.workDayBackgroundOutlet.image = #imageLiteral(resourceName: "workDayBackgroundGreen")
                }
                workDaysCell.workingTimeLabelOutlet.text = formStartWorkEndWork(index: indexPath.row).0 + " - " + formStartWorkEndWork(index: indexPath.row).1
                workDaysCell.launchBreakTimeLabelOutlet.text = formStartLaunchEndWork(index: indexPath.row).0 + " - " + formStartLaunchEndWork(index: indexPath.row).1
                workDaysCell.workDayImageViewOutlet.image = UIImage(named: "tuesday")
            case 2:
                if Int((arrayOfDays?[indexPath.row].dayType)!)! == 0 {
                    workDaysCell.workDayBackgroundOutlet.image = #imageLiteral(resourceName: "workDayBackgroundGray")
                    workDaysCell.launchBreakLabelOutlet.isHidden = true
                    workDaysCell.workingTimeLabelOutlet.isHidden = true
                    workDaysCell.workingLabelOutlet.isHidden = true
                    workDaysCell.launchBreakTimeLabelOutlet.isHidden = true
                } else {
                    workDaysCell.workDayBackgroundOutlet.image = #imageLiteral(resourceName: "workDayBackgroundGreen")
                }
                workDaysCell.workingTimeLabelOutlet.text = formStartWorkEndWork(index: indexPath.row).0 + " - " + formStartWorkEndWork(index: indexPath.row).1
                workDaysCell.launchBreakTimeLabelOutlet.text = formStartLaunchEndWork(index: indexPath.row).0 + " - " + formStartLaunchEndWork(index: indexPath.row).1
                workDaysCell.workDayImageViewOutlet.image = UIImage(named: "wensday")
            case 3:
                if Int((arrayOfDays?[indexPath.row].dayType)!)! == 0 {
                    workDaysCell.workDayBackgroundOutlet.image = #imageLiteral(resourceName: "workDayBackgroundGray")
                    workDaysCell.launchBreakLabelOutlet.isHidden = true
                    workDaysCell.workingTimeLabelOutlet.isHidden = true
                    workDaysCell.workingLabelOutlet.isHidden = true
                    workDaysCell.launchBreakTimeLabelOutlet.isHidden = true
                } else {
                    workDaysCell.workDayBackgroundOutlet.image = #imageLiteral(resourceName: "workDayBackgroundGreen")
                }
                workDaysCell.workingTimeLabelOutlet.text = formStartWorkEndWork(index: indexPath.row).0 + " - " + formStartWorkEndWork(index: indexPath.row).1
                workDaysCell.launchBreakTimeLabelOutlet.text = formStartLaunchEndWork(index: indexPath.row).0 + " - " + formStartLaunchEndWork(index: indexPath.row).1
                workDaysCell.workDayImageViewOutlet.image = UIImage(named: "thurday")
            case 4:
                if Int((arrayOfDays?[indexPath.row].dayType)!)! == 0 {
                    workDaysCell.workDayBackgroundOutlet.image = #imageLiteral(resourceName: "workDayBackgroundGray")
                    workDaysCell.launchBreakLabelOutlet.isHidden = true
                    workDaysCell.workingTimeLabelOutlet.isHidden = true
                    workDaysCell.workingLabelOutlet.isHidden = true
                    workDaysCell.launchBreakTimeLabelOutlet.isHidden = true
                } else {
                    workDaysCell.workDayBackgroundOutlet.image = #imageLiteral(resourceName: "workDayBackgroundGreen")
                }
                workDaysCell.workingTimeLabelOutlet.text = formStartWorkEndWork(index: indexPath.row).0 + " - " + formStartWorkEndWork(index: indexPath.row).1
                workDaysCell.launchBreakTimeLabelOutlet.text = formStartLaunchEndWork(index: indexPath.row).0 + " - " + formStartLaunchEndWork(index: indexPath.row).1
                workDaysCell.workDayImageViewOutlet.image = UIImage(named: "friday")
            case 5:
                if Int((arrayOfDays?[indexPath.row].dayType)!)! == 0 {
                    workDaysCell.workDayBackgroundOutlet.image = #imageLiteral(resourceName: "workDayBackgroundGray")
                    workDaysCell.launchBreakLabelOutlet.isHidden = true
                    workDaysCell.workingTimeLabelOutlet.isHidden = true
                    workDaysCell.workingLabelOutlet.isHidden = true
                    workDaysCell.launchBreakTimeLabelOutlet.isHidden = true
                } else {
                    workDaysCell.workDayBackgroundOutlet.image = #imageLiteral(resourceName: "workDayBackgroundGreen")
                }
                workDaysCell.workingTimeLabelOutlet.text = formStartWorkEndWork(index: indexPath.row).0 + " - " + formStartWorkEndWork(index: indexPath.row).1
                workDaysCell.launchBreakTimeLabelOutlet.text = formStartLaunchEndWork(index: indexPath.row).0 + " - " + formStartLaunchEndWork(index: indexPath.row).1
                workDaysCell.workDayImageViewOutlet.image = UIImage(named: "saturday")
            case 6:
                if Int((arrayOfDays?[indexPath.row].dayType)!)! == 0 {
                    workDaysCell.workDayBackgroundOutlet.image = #imageLiteral(resourceName: "workDayBackgroundGray")
                    workDaysCell.launchBreakLabelOutlet.isHidden = true
                    workDaysCell.workingTimeLabelOutlet.isHidden = true
                    workDaysCell.workingLabelOutlet.isHidden = true
                    workDaysCell.launchBreakTimeLabelOutlet.isHidden = true
                } else {
                    workDaysCell.workDayBackgroundOutlet.image = #imageLiteral(resourceName: "workDayBackgroundGreen")
                }
                workDaysCell.workingTimeLabelOutlet.text = formStartWorkEndWork(index: indexPath.row).0 + " - " + formStartWorkEndWork(index: indexPath.row).1
                workDaysCell.launchBreakTimeLabelOutlet.text = formStartLaunchEndWork(index: indexPath.row).0 + " - " + formStartLaunchEndWork(index: indexPath.row).1
                workDaysCell.workDayImageViewOutlet.image = UIImage(named: "sunday")
            default:
                break
            }
        }
        workDaysCell.isUserInteractionEnabled = false
        
        return workDaysCell
    }
}

extension WorkDaysVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89
    }
}
