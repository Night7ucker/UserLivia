//
//  MainScreenController.swift
//  User
//
//  Created by Egor Yanukovich on 9/22/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class MainScreenController: UIViewController {
    
    
    
    
    @IBOutlet weak var personImage: CustomImageView!
    
    @IBOutlet weak var mainScreenTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        personImage.layer.borderWidth = 3.0
        personImage.layer.borderColor = UIColor.white.cgColor
        
        mainScreenTableView.delegate = self
        mainScreenTableView.dataSource = self
        mainScreenTableView.layer.cornerRadius = 5.0
        
        
    }
    
    
    
}

extension MainScreenController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MainScreenCell = tableView.dequeueReusableCell(withIdentifier: "mainScreenCell", for: indexPath) as! MainScreenCell
        switch indexPath.row {
        case 0:
            cell.mainIcon.image = #imageLiteral(resourceName: "orderImage")
            cell.mainLabel.text = "Make Order"
            cell.detailLabel.text = "GENERATE ORDER"
            
        case 1:
            cell.mainIcon.image = #imageLiteral(resourceName: "searchMedecine")
            cell.mainLabel.text = "Over the Counter Products"
            cell.detailLabel.text = "SEARCH FOR ITEMS"
            
        case 2:
            cell.mainIcon.image = #imageLiteral(resourceName: "purchaseHistoryImage")
            cell.mainLabel.text = "History"
            cell.detailLabel.text = "ORDERS, APPOINTMENTS, PAIMENTS"
            
        case 3:
            cell.mainIcon.image = #imageLiteral(resourceName: "reminderImage")
            cell.mainLabel.text = "Reminders & Results"
            cell.detailLabel.text = "ПРИВЕТ"
            
        case 4:
            cell.mainIcon.image = #imageLiteral(resourceName: "inviteFriendsImage")
            cell.mainLabel.text = "Invite Friends"
            cell.detailLabel.text = "INVITE FROM CONTACTS"
            
        case 5:
            cell.mainIcon.image = #imageLiteral(resourceName: "settingsImage")
            cell.mainLabel.text = "Settings"
            cell.detailLabel.text = "APP SETTINGS"
            
        default:
            break
        }
        return cell
    }
}
extension MainScreenController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
