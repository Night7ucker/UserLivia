//
//  WorkDaysVC.swift
//  User
//
//  Created by User on 10/5/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class WorkDaysVC: RootViewController {

    @IBOutlet weak var workDaysTableViewOutlet: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        addBackButtonAndTitleToNavigationBar(title: "Work time")
        
        workDaysTableViewOutlet.delegate = self
        workDaysTableViewOutlet.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        switch indexPath.row {
        case 0:
            workDaysCell.workDayImageViewOutlet.image = UIImage(named: "monday")
        case 1:
            workDaysCell.workDayImageViewOutlet.image = UIImage(named: "tuesday")
        case 2:
            workDaysCell.workDayImageViewOutlet.image = UIImage(named: "wensday")
        case 3:
            workDaysCell.workDayImageViewOutlet.image = UIImage(named: "thurday")
        case 4:
            workDaysCell.workDayImageViewOutlet.image = UIImage(named: "friday")
        case 5:
            workDaysCell.workDayImageViewOutlet.image = UIImage(named: "saturday")
            workDaysCell.workDayBackgroundOutlet.image = #imageLiteral(resourceName: "workDayBackgroundGray")
        case 6:
            workDaysCell.workDayImageViewOutlet.image = UIImage(named: "sunday")
            workDaysCell.workDayBackgroundOutlet.image = #imageLiteral(resourceName: "workDayBackgroundGray")
        default:
            break
        }
        
        workDaysCell.workingTimeLabelOutlet.text = "08:46 - 21:00"
        workDaysCell.launchBreakLabelOutlet.text = "13:00 - 14:00"
        
        return workDaysCell
    }
}

extension WorkDaysVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89
    }
}
