//
//  SettingsController.swift
//  User
//
//  Created by Egor Yanukovich on 9/24/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import RealmSwift

class SettingsController: RootViewController, SigninViewControllerDelegate {
    
    var listOfPrescriptionViewController: ListOfPrescriptionsVC {
        let listOfPrescriptionsStoryboard = UIStoryboard(name: "ListOfPrescriptions", bundle: nil)
        let listOfPrescriptionsVC = listOfPrescriptionsStoryboard.instantiateViewController(withIdentifier: "kListOfPrescriptionsVC")
        as! ListOfPrescriptionsVC
        return listOfPrescriptionsVC
    }
    
    var regisrationViewController: RegistrationViewController {
        let mainViewStoryboard = UIStoryboard(name: "MainViewsStoryboard", bundle: nil)
        let registrationVC = mainViewStoryboard.instantiateViewController(withIdentifier: "kRegistrationViewController") as! RegistrationViewController
        return registrationVC
    }
    
    
    
    @IBOutlet weak var settingsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBackButtonAndTitleToNavigationBar(title: "Settings")
        
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        
        settingsTableView.layer.cornerRadius = 10.0
        
    }
    
    func pushToRegistrationViewController() {
        navigationController?.pushViewController(regisrationViewController, animated: false)
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
                cell.mainScreenImage.image = UIImage(named: "prescriptions")
                cell.mainLabel.text = "List of Prescriptions"
                
            case 2:
                cell.mainScreenImage.image = UIImage(named: "contact")
                cell.mainLabel.text = "Contact us"
                
            case 4:
                cell.mainScreenImage.image = UIImage(named: "logout")
                cell.mainLabel.text = "Logout from this device only"
                
            case 5:
                cell.mainScreenImage.image = UIImage(named: "logout")
                cell.mainLabel.text = "Logout from all devices"
                
            default:
                break
            }
            
        case 1, 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "settingsWithDetailInfoCell", for: indexPath) as! MainScreenCell
            switch indexPath.row {
            case 1:
                cell.mainScreenImage.image = UIImage(named: "faq")
                cell.mainLabel.text = "FAQ"
                cell.detailLabel.text = "FREQUENTLY ASKED QUESTION(S)"
                
            case 3:
                cell.mainScreenImage.image = UIImage(named: "phone")
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
        switch indexPath.row {
        case 0:
            if RealmDataManager.getTokensFromRealm().count != 0 {
                self.navigationController?.pushViewController(self.listOfPrescriptionViewController, animated: false)
            } else {
                let loadingAnimationStoryboard = UIStoryboard(name: "SigninViewStoryboard", bundle: nil)
                let signinViewController = loadingAnimationStoryboard.instantiateViewController(withIdentifier: "kSigninViewController") as! SigninViewController
                signinViewController.delegate = self
                self.present(signinViewController, animated: false, completion: nil)
            }
        case 1:
            let SettingsStoryboard = UIStoryboard(name: "Settings", bundle: nil)
            let SettingsViewController = SettingsStoryboard.instantiateViewController(withIdentifier: "kFAQViewController") as? FAQViewController
            self.navigationController?.pushViewController(SettingsViewController!, animated: true)
        case 2:
            print("asd")
            let googleUrlString = "googlegmail:///co?subject=Hello&body=Hi"
            if let googleUrl = NSURL(string: googleUrlString) {
                // show alert to choose app
                if UIApplication.shared.canOpenURL(googleUrl as URL) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(googleUrl as URL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(googleUrl as URL)
                    }
                }
            }
        case 3:
            if RealmDataManager.getTokensFromRealm().count != 0 {
                let changePhoneNumberStoryboard = UIStoryboard(name: "ChangePhoneNumber", bundle: nil)
                let changePhoneNumberViewController = changePhoneNumberStoryboard.instantiateViewController(withIdentifier: "kChangePhoneNumberVC") as! ChangePhoneNumberVC
                self.navigationController?.pushViewController(changePhoneNumberViewController, animated: false)
            } else {
                let loadingAnimationStoryboard = UIStoryboard(name: "SigninViewStoryboard", bundle: nil)
                let signinViewController = loadingAnimationStoryboard.instantiateViewController(withIdentifier: "kSigninViewController") as! SigninViewController
                signinViewController.delegate = self
                self.present(signinViewController, animated: false, completion: nil)
            }
        case 4, 5:
            let realm = try! Realm()
            try! realm.write {
                realm.deleteAll()
            }
            self.navigationController?.pushViewController(self.regisrationViewController, animated: false)
        default:
            break
        }
        }
    }
}

extension SettingsController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
}
