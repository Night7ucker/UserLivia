//
//  SettingsController.swift
//  User
//
//  Created by Egor Yanukovich on 9/24/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
    
    @IBOutlet weak var settingsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        backButton.setTitle("", for: .normal)
        
        backButton.setBackgroundImage(UIImage(named: "backButtonImage"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        
        let backButtonBarButton = UIBarButtonItem(customView: backButton)
        
        let titleLabel = UILabel()
        titleLabel.text = "Settings"
        titleLabel.textColor = .white
        titleLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        let titleLabelBarButton = UIBarButtonItem(customView: titleLabel)
        
        navigationItem.setLeftBarButtonItems([backButtonBarButton, titleLabelBarButton], animated: true)
        
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        
        settingsTableView.layer.cornerRadius = 10.0
        
    }
    
    func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
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
