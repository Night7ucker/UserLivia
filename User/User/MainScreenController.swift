//
//  MainScreenController.swift
//  User
//
//  Created by Egor Yanukovich on 9/22/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import RealmSwift

protocol SigninViewControllerDelegate: class {
    func pushToRegistrationViewController()
}

class MainScreenController: RootViewController, SigninViewControllerDelegate {
    
    
    @IBOutlet weak var scrollViewOutlet: UIScrollView!
    @IBOutlet weak var fullNameLabelOutlet: UILabel!
    @IBOutlet weak var userProfileImageOutlet: CustomImageView!
    @IBOutlet weak var personImage: CustomImageView!
    @IBOutlet weak var mainScreenTableView: UITableView!
    @IBOutlet var cartViewOutlet: DrugsView!
    @IBOutlet var amountOfDrugsInCartOutlet: UILabel!
    
    
    
    var userIsRegistred  = false
    let countryCodesDataManagerObject = GetCountryCodesRequest()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(scrollViewOutlet.frame)
//        scrollViewOutlet.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 100)
//        print(scrollViewOutlet.frame)
//        scrollViewOutlet.isDirectionalLockEnabled = true
        mainScreenTableView.backgroundColor = .clear
        if userIsRegistred == false {
            fullNameLabelOutlet.isHidden = true
        } else {
            let baseImageUrl = "https://test.liviaapp.com"
            let obj = GetUserProfileRequest()
            obj.GetUserProfileFunc(completion: { (success) in
                if success {
                    OrdersCountRequest.getOrdersList(completion: { (success) in
                        if success {
                            self.mainScreenTableView.reloadData()
                        }
                    })
                    self.fullNameLabelOutlet.text = RealmDataManager.getUserDataFromRealm()[0].namePrefix!+" "+RealmDataManager.getUserDataFromRealm()[0].firstName!+" "+RealmDataManager.getUserDataFromRealm()[0].lastName!
                    if RealmDataManager.getUserDataFromRealm()[0].avatar != nil{
                        let fullImageUrl = baseImageUrl+RealmDataManager.getUserDataFromRealm()[0].avatar!
                        self.getImage(pictureUrl: fullImageUrl) { success, image in
                            if success {
                                self.personImage.image = image
                            }
                        }
                        print(RealmDataManager.getPushTokenFromRealm()[0].pushToken!)
                        let obj = PushTokenRequest()
                        obj.getPushTokenRequest()
                    }
                    
                }
            })
        }
        
        personImage.layer.borderWidth = 3.0
        personImage.layer.borderColor = UIColor.white.cgColor
        
        mainScreenTableView.delegate = self
        mainScreenTableView.dataSource = self
        
        

        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        navigationController?.isNavigationBarHidden = true
        cartViewOutlet.isHidden = true

        if RealmDataManager.getUserDataFromRealm().count != 0 {
            OrdersCountRequest.getOrdersList(completion: { (success) in
                if success {
                    self.mainScreenTableView.reloadData()
                }
            })
        }

        if RealmDataManager.getAddedDrugsDataFromRealm().count != 0 {
            cartViewOutlet.isHidden = false
            amountOfDrugsInCartOutlet.text = "("+String(describing: RealmDataManager.getAddedDrugsDataFromRealm().count)+")"
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        navigationController?.isNavigationBarHidden = false
    }
    
    
    @IBAction func viewCartAction(_ sender: UIButton) {
        let AddToCartStoryboard = UIStoryboard(name: "AddToCart", bundle: nil)
        let AddToCartViewController = AddToCartStoryboard.instantiateViewController(withIdentifier: "kAddToCartStoryboardId") as? AddToCartViewController
        navigationController?.pushViewController(AddToCartViewController!, animated: true)
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
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 6
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : MainScreenCell!
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "mainScreenCell", for: indexPath) as! MainScreenCell
            
            cell.mainScreenImage.image = UIImage(named: "doctorImage")
            
            cell.mainLabel.text = "Find a doctor"
            cell.detailLabel.text = "BOOK APPOINTMENT"
            cell.layer.cornerRadius = 10
            cell.layer.shadowRadius = 1
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOpacity = 0.8
        case 1:
            switch indexPath.row {
            case 0, 1, 2, 4, 5:
                cell = tableView.dequeueReusableCell(withIdentifier: "mainScreenCell", for: indexPath) as! MainScreenCell
                switch indexPath.row {
                case 0:
                    cell.fillCellInfo(mainScreenImage: UIImage(named: "makeOrder")!, mainLabel: "Make Order", detailLabel: "GENERATE ORDER")
                    let path = UIBezierPath(roundedRect:cell.bounds,
                                            byRoundingCorners:[.topRight, .topLeft],
                                            cornerRadii: CGSize(width: 10, height:  10))
                    
                    let maskLayer = CAShapeLayer()
                    
                    maskLayer.path = path.cgPath
                    cell.layer.mask = maskLayer
                case 1:
                    cell.fillCellInfo(mainScreenImage: UIImage(named: "overTheCounterProducts")!, mainLabel: "Over the Counter Products", detailLabel: "SEARCH FOR ITEMS")
                case 2:
                    if RealmDataManager.getOrdersCountFromRealm().count != 0 {
                        cell.fillCellInfo(mainScreenImage: UIImage(named: "orders")!, mainLabel: "Orders Appointments Payments", detailLabel:"YOU HAVE "+String(describing: RealmDataManager.getOrdersCountFromRealm()[0].allOrders)+" ORDERS")
                        
                    } else {
                        cell.fillCellInfo(mainScreenImage: UIImage(named: "orders")!, mainLabel: "Orders Appointments Payments", detailLabel: "")
                    }
                case 4:
                    cell.fillCellInfo(mainScreenImage: UIImage(named: "inviteFriends")!, mainLabel: "Invite Friends", detailLabel: "INVITE FROM CONTACTS")
                case 5:
                    cell.fillCellInfo(mainScreenImage: UIImage(named: "settings")!, mainLabel: "Settings", detailLabel: "APP SETTINGS")
                    let path = UIBezierPath(roundedRect:cell.bounds,
                                            byRoundingCorners:[.bottomLeft, .bottomRight],
                                            cornerRadii: CGSize(width: 10, height:  10))
                    
                    let maskLayer = CAShapeLayer()
                    
                    maskLayer.path = path.cgPath
                    cell.layer.mask = maskLayer
                default:
                    break
                }
            case 3:
                cell = tableView.dequeueReusableCell(withIdentifier: "mainScreenSecondCell", for: indexPath) as! MainScreenCell
                
                cell.fillCellInfo(mainScreenImage: UIImage(named: "reminders")!, mainLabel: "Reminders & Results")
            default:
                break
            }
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
        
        DispatchQueue.main.async {
            switch indexPath.section {
            case 0:
                if RealmDataManager.getUserDataFromRealm().count != 0 {
                    let findDoctorStoryboard = UIStoryboard(name: "FindDoctor", bundle: nil)
                    let findDoctorSpecialityViewController = findDoctorStoryboard.instantiateViewController(withIdentifier: "kFindDoctorVC") as! FindDoctorVC
                    self.navigationController?.pushViewController(findDoctorSpecialityViewController, animated: false)
                } else {
                    let mainViewStoryboard = UIStoryboard(name: "MainViewsStoryboard", bundle: nil)
                    let searchForItemsViewController = mainViewStoryboard.instantiateViewController(withIdentifier: "kSearchForItemsViewController") as! SearchForItemsViewController
                    self.navigationController?.pushViewController(searchForItemsViewController, animated: false)
                }
                
            case 1:
                switch indexPath.row {
                case 0:
                    let settingsStoryboard = UIStoryboard(name: "MainViewsStoryboard", bundle: nil)
                    let settingsViewController = settingsStoryboard.instantiateViewController(withIdentifier: "kMakeOrderViewController") as? MakeOrderViewController
                    self.navigationController?.pushViewController(settingsViewController!, animated: true)
                case 1:
                    let ChooseCityStoryboard = UIStoryboard(name: "MainViewsStoryboard", bundle: Bundle.main)
                    let ChooseCityController = ChooseCityStoryboard.instantiateViewController(withIdentifier: "kSearchForItemsViewController") as! SearchForItemsViewController
                    if RealmDataManager.getTokensFromRealm().count == 0 {
                        ChooseCityController.checkIsRegistered = false
                    }
                    ChooseCityController.transitionFromMainController = true
                    self.navigationController?.pushViewController(ChooseCityController, animated: true)
                    
                case 2:
                    if RealmDataManager.getTokensFromRealm().count == 0 {
                        let signinViewStoryboard = UIStoryboard(name: "SigninViewStoryboard", bundle: nil)
                        let signinViewController = signinViewStoryboard.instantiateViewController(withIdentifier: "kSigninViewController") as? SigninViewController
                        signinViewController?.delegate = self
                        self.present(signinViewController!, animated: false, completion: nil)
                    } else {
                        let realm = try! Realm()
                        if RealmDataManager.getOrdersListFromRealm().count != 0 {
                            try! realm.write {
                                realm.delete(RealmDataManager.getOrdersListFromRealm())
                            }
                        }
                        OrdersListRequest.getOrdersList(completion: { (success) in
                            if success {
                                let ordersAppointmentsPayments = UIStoryboard(name: "Orders Appointments Payments", bundle: nil)
                                let ordersPaymentsController = ordersAppointmentsPayments.instantiateViewController(withIdentifier: "kOrdersPaymentsController") as? OrdersPaymentsController
                                self.navigationController?.pushViewController(ordersPaymentsController!, animated: true)
                            }
                        })
                    }
                case 3:
                    if RealmDataManager.getTokensFromRealm().count == 0 {
                        let signinViewStoryboard = UIStoryboard(name: "SigninViewStoryboard", bundle: nil)
                        let signinViewController = signinViewStoryboard.instantiateViewController(withIdentifier: "kSigninViewController") as? SigninViewController
                        signinViewController?.delegate = self
                        self.present(signinViewController!, animated: false, completion: nil)
                    } else {
                        let refillsAndRemindersStoryboard = UIStoryboard(name: "RefillsAndReminders", bundle: nil)
                        let settingsViewController = refillsAndRemindersStoryboard.instantiateViewController(withIdentifier: "kRemindersViewController") as? RemindersViewController
                        self.navigationController?.pushViewController(settingsViewController!, animated: true)
                    }
                    
                case 4:
                    let inviteFriendsStoryboard = UIStoryboard(name: "InviteFriends", bundle: nil)
                    let inviteFriendsController = inviteFriendsStoryboard.instantiateViewController(withIdentifier: "kInviteFriendsController") as? InviteFriendsController
                    self.navigationController?.pushViewController(inviteFriendsController!, animated: true)
                    
                case 5:
                    let settingsStoryboard = UIStoryboard(name: "Settings", bundle: nil)
                    let settingsViewController = settingsStoryboard.instantiateViewController(withIdentifier: "kSettingsController") as? SettingsController
                    self.navigationController?.pushViewController(settingsViewController!, animated: true)
                default:
                    break
                }

            default:
                break
            }
            }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 22
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let emptyView = UIView()
        emptyView.backgroundColor = .clear
        return emptyView
    }
}

extension MainScreenController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x>0 {
            scrollView.contentOffset.x = 0
        }
    }
}
