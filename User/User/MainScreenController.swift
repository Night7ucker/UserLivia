//
//  MainScreenController.swift
//  User
//
//  Created by Egor Yanukovich on 9/22/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

protocol SigninViewControllerDelegate: class {
    func pushToRegistrationViewController()
}

class MainScreenController: UIViewController, SigninViewControllerDelegate {
    
    
    @IBOutlet weak var fullNameLabelOutlet: UILabel!
    
    @IBOutlet weak var userProfileImageOutlet: CustomImageView!
    
    @IBOutlet weak var personImage: CustomImageView!
    
    @IBOutlet weak var mainScreenTableView: UITableView!
    
    var userIsRegistred  = false
    let countryCodesDataManagerObject = CountryCodesDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userIsRegistred == false {
            fullNameLabelOutlet.isHidden = true
        } else {
            let baseImageUrl = "https://test.liviaapp.com"
            let obj = GetUserProfileRequest()
            obj.GetUserProfileFunc(completion: { (success) in
                if success {
                    self.fullNameLabelOutlet.text = RealmDataManager.getUserDataFromRealm()[0].namePrefix!+" "+RealmDataManager.getUserDataFromRealm()[0].firstName!+" "+RealmDataManager.getUserDataFromRealm()[0].lastName!
                    let fullImageUrl = baseImageUrl+RealmDataManager.getUserDataFromRealm()[0].avatar!
                    let object = CountryCodesDataManager()
                    object.getImage(pictureUrl: fullImageUrl) { success, image in
                        if success {
                            self.personImage.image = image
                        }
                    }
                    
                }
            })
        }
        
        personImage.layer.borderWidth = 3.0
        personImage.layer.borderColor = UIColor.white.cgColor
        
        mainScreenTableView.delegate = self
        mainScreenTableView.dataSource = self
        mainScreenTableView.layer.cornerRadius = 10.0
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    
    @IBAction func editProfileButtontTapped(_ sender: UIButton) {
        
        if RealmDataManager.getTokensFromRealm().count == 0 {
            let signinViewStoryboard = UIStoryboard(name: "SigninViewStoryboard", bundle: nil)
            let signinViewController = signinViewStoryboard.instantiateViewController(withIdentifier: "kSigninViewController") as? SigninViewController
            signinViewController?.delegate = self
            present(signinViewController!, animated: false, completion: nil)
        } else {
            let editProfileStoryboard = UIStoryboard(name: "EditProfile", bundle: nil)
            let editProfileViewController = editProfileStoryboard.instantiateViewController(withIdentifier: "kEditingProfileViewController") as? EditingProfileViewController
            self.navigationController?.pushViewController(editProfileViewController!, animated: false)
        }
        
    }
    
    func pushToRegistrationViewController() {
        let mainViewStoryboard = UIStoryboard(name: "MainViewsStoryboard", bundle: nil)
        let registrationViewController = mainViewStoryboard.instantiateViewController(withIdentifier: "kRegistrationViewController") as? RegistrationViewController
        navigationController?.pushViewController(registrationViewController!, animated: false)
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
        var cell : MainScreenCell!
        switch indexPath.row {
        case 0,1,2,4,5:
            cell = tableView.dequeueReusableCell(withIdentifier: "mainScreenCell", for: indexPath) as! MainScreenCell
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
                cell.mainLabel.text = "Orders Appointments Payments"
                cell.detailLabel.text = "YOU HAVE 0 ORDERS"
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
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "mainScreenSecondCell", for: indexPath) as! MainScreenCell
            cell.mainIcon.image = #imageLiteral(resourceName: "reminderImage")
            cell.mainLabel.text = "Reminders & Results"
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        switch indexPath.row {
        case 0:
            let settingsStoryboard = UIStoryboard(name: "MainViewsStoryboard", bundle: nil)
            let settingsViewController = settingsStoryboard.instantiateViewController(withIdentifier: "kMakeOrderViewController") as? MakeOrderViewController
            self.navigationController?.pushViewController(settingsViewController!, animated: true)
        case 1:
            if RealmDataManager.getTokensFromRealm().count == 0 {
                let ChooseCityStoryboard = UIStoryboard(name: "MainViewsStoryboard", bundle: Bundle.main)
                let ChooseCityController = ChooseCityStoryboard.instantiateViewController(withIdentifier: "kSearchForItemsViewController") as! SearchForItemsViewController
                ChooseCityController.checkIsRegistered = false
                self.navigationController?.pushViewController(ChooseCityController, animated: true)
            } else {
                let mainViewStoryboard = UIStoryboard(name: "MainViewsStoryboard", bundle: nil)
                let settingsViewController = mainViewStoryboard.instantiateViewController(withIdentifier: "kSearchForItemsViewController") as? SearchForItemsViewController
                self.navigationController?.pushViewController(settingsViewController!, animated: true)
            }
            
            
        case 2:
            print("2")
        case 3:
            if RealmDataManager.getTokensFromRealm().count == 0 {
                let signinViewStoryboard = UIStoryboard(name: "SigninViewStoryboard", bundle: nil)
                let signinViewController = signinViewStoryboard.instantiateViewController(withIdentifier: "kSigninViewController") as? SigninViewController
                signinViewController?.delegate = self
                present(signinViewController!, animated: false, completion: nil)
            } else {
                let refillsAndRemindersStoryboard = UIStoryboard(name: "RefillsAndReminders", bundle: nil)
                let settingsViewController = refillsAndRemindersStoryboard.instantiateViewController(withIdentifier: "kRemindersViewController") as? RemindersViewController
                self.navigationController?.pushViewController(settingsViewController!, animated: true)
            }
            
        case 4:
            print("4")
        case 5:
            print("5")
            let settingsStoryboard = UIStoryboard(name: "Settings", bundle: nil)
            let settingsViewController = settingsStoryboard.instantiateViewController(withIdentifier: "kSettingsController") as? SettingsController
            self.navigationController?.pushViewController(settingsViewController!, animated: true)
        default:
            break
        }
    }
    
    
    
}
