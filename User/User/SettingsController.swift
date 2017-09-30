//
//  SettingsController.swift
//  User
//
//  Created by Egor Yanukovich on 9/24/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class SettingsController: RootViewController {
    
    @IBOutlet weak var settingsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBackButtonAndTitleToNavigationBar(title: "Settings")
        
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        
        settingsTableView.layer.cornerRadius = 10.0
        
    }
    
}

extension SettingsController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : MainScreenCell!
        switch indexPath.row {
        case 0, 2, 4, 5:
            cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! MainScreenCell
            switch indexPath.row {
            case 0:
                cell.mainIcon.image = #imageLiteral(resourceName: "orderImage")
                cell.mainLabel.text = "List of Prescriptions"
                
            case 2:
                cell.mainIcon.image = #imageLiteral(resourceName: "contactUsImage")
                cell.mainLabel.text = "Contact us"
                
            case 4:
                cell.mainIcon.image = #imageLiteral(resourceName: "logoutImage")
                cell.mainLabel.text = "Logout from this device only"
                
            case 5:
                cell.mainIcon.image = #imageLiteral(resourceName: "logoutImage")
                cell.mainLabel.text = "Logout from all devices"
                
            default:
                break
            }
            
        case 1, 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "settingsWithDetailInfoCell", for: indexPath) as! MainScreenCell
            switch indexPath.row {
            case 1:
                cell.mainIcon.image = #imageLiteral(resourceName: "faqImage")
                cell.mainLabel.text = "FAQ"
                cell.detailLabel.text = "FREQUENTLY ASKED QUESTION(S)"
                
            case 3:
                cell.mainIcon.image = #imageLiteral(resourceName: "phoneImage")
                cell.mainLabel.text = "Change phone number"
                cell.detailLabel.text = "PRESS TO CHANGE NUMBER"
                
            default:
                break
            }
            
        default:
            break
        }
        return cell
    }
}

extension SettingsController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
}
