//
//  ReviewYourOrdedViewController.swift
//  User
//
//  Created by User on 10/3/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//


// TODO:
// self-collect - 0, 1
// manual - checkbox 0, 1
// esli manual - 1 nado brat' pharm id
// pharm id polu4aetsya s page controla so vtoroi vkladki
// s tablici page controla

// zapros na apteki - prosto po coordinatam
// kogda na page control idu na vtoruu vkladku idet zapros c current coordinatami i na etoi vkladke poyavlyaetsya spisok aptek
// order kak nibud' otdelyanay model


import UIKit
import GoogleMaps
import GooglePlaces
import RealmSwift

protocol OrderSendedPopupViewControllerDelegate {
    func pushtToMainScreenController()
}

class ReviewYourOrdedViewController: RootViewController, OrderSendedPopupViewControllerDelegate {
    
    @IBOutlet weak var requestPriceButtonOutlet: UIButton!
    @IBOutlet weak var reviewYourOrderTableViewOutlet: UITableView!
    
    var sectionNames = ["Drugs:", "Location:", "Order Type:"]
    var arrayOfOrderedDrugs = [String]()
    
    var pharmacyID: String? = nil
    var pharmacy: Pharmacy?
    
    var mainScreenViewController: MainScreenController {
        let mainScreenStoryboard = UIStoryboard(name: "MainScreen", bundle: nil)
        let mainScreenViewController = mainScreenStoryboard.instantiateViewController(withIdentifier: "kMainScreenController") as! MainScreenController
        return mainScreenViewController
    }
    
    var loadingViewController: LoadingAnimationViewController {
        let loadingAnimationStoryboard = UIStoryboard(name: "LoadingAnimation", bundle: nil)
        let loadingAnimationViewController = loadingAnimationStoryboard.instantiateViewController(withIdentifier: "kLoadingAnimationViewController") as! LoadingAnimationViewController
        return loadingAnimationViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        try! realm.write {
            RealmDataManager.getSendingOrderFromRealm()[0].pharmID = pharmacyID
        }
        
        if pharmacyID != nil {
            sectionNames.append("Pharmacy:")
            let pharmaciesArray = RealmDataManager.getPharmaciesFromRealm()
            for pharmacyElement in pharmaciesArray {
                if pharmacyElement.userId == pharmacyID {
                    pharmacy = pharmacyElement
                }
            }
        }
        
        reviewYourOrderTableViewOutlet.delegate = self
        reviewYourOrderTableViewOutlet.dataSource = self
        
        
        configureNavigationBar()
        addBackButtonAndTitleToNavigationBar(title: "Review your order")
        
        
        view.backgroundColor = Colors.Root.lightGrayColor
        requestPriceButtonOutlet.backgroundColor = Colors.Root.lightBlueColor
        reviewYourOrderTableViewOutlet.separatorStyle = .none
        reviewYourOrderTableViewOutlet.backgroundColor = Colors.Root.lightGrayColor
        
        
        let orderedDrugs = RealmDataManager.getAddedDrugsDataFromRealm()
        for i in 0..<orderedDrugs.count {
            let stringToAppend = "- " + orderedDrugs[i].brandName!
            var secondStringToAppend = String()
            if orderedDrugs[i].quantityMeasuring != nil {
                secondStringToAppend = "(" + String(orderedDrugs[i].amount) + orderedDrugs[i].quantityMeasuring! + ")"
            } else{
                secondStringToAppend = "(" + String(orderedDrugs[i].amount) + ")"
            }
            
            let finalString = stringToAppend + secondStringToAppend
            arrayOfOrderedDrugs.append(finalString)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func pushtToMainScreenController() {
        // form request here
        
        
        let realm = try! Realm()
        if RealmDataManager.getAddedDrugsDataFromRealm().count != 0 {
            try! realm.write {
                realm.delete(RealmDataManager.getAddedDrugsDataFromRealm())
            }
        }
        navigationController?.pushViewController(mainScreenViewController, animated: false)
    }
    
    
    @IBAction func requestPriceButtonTapped(_ sender: UIButton) {
        SendOrdersRequest.postRequestToOrderDrugs() { success in
            
        }
        let reviewOrderStoryboard = UIStoryboard(name: "ReviewYourOrder", bundle: nil)
        let orderSendedPopupViewController = reviewOrderStoryboard.instantiateViewController(withIdentifier: "kOrderSendedPopupViewController") as! OrderSendedPopupViewController
        orderSendedPopupViewController.delegate = self
        self.present(orderSendedPopupViewController, animated: false)
//        present(loadingViewController, animated: false)
//        SendOrdersRequest.postRequestToOrderDrugs() { (success) in
//            DispatchQueue.main.sync {
//                self.loadingViewController.dismiss(animated: false, completion: nil)
//                let reviewOrderStoryboard = UIStoryboard(name: "ReviewYourOrder", bundle: nil)
//                let orderSendedPopupViewController = reviewOrderStoryboard.instantiateViewController(withIdentifier: "kOrderSendedPopupViewController") as! OrderSendedPopupViewController
//                orderSendedPopupViewController.delegate = self
//                self.present(orderSendedPopupViewController, animated: false)
//            }
//        }
        // navigation controller visible view controller 
        // napiat' poptoviewcontroller
    }
}

extension ReviewYourOrdedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return arrayOfOrderedDrugs.count
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let descriptionCell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell") as! OrderReviewTableViewCell
            
            descriptionCell.drugNameLabel.text = arrayOfOrderedDrugs[indexPath.row]
            
            return descriptionCell
        case 1:
            let mapCell = tableView.dequeueReusableCell(withIdentifier: "orderMapCell") as! OrderMapTableViewCell
            
            return mapCell
        case 2:
            let deliveryCell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell") as! OrderReviewTableViewCell
            
            let deliveryType = Int(RealmDataManager.getSendingOrderFromRealm()[0].selfCollect!)!
            switch deliveryType {
            case 0:
                deliveryCell.drugNameLabel.text = "- Self-collect"
            case 1:
                deliveryCell.drugNameLabel.text = "- Delivery"
            default:
                break
            }
            return deliveryCell
            
        case 3:
            let pharmacyCell = tableView.dequeueReusableCell(withIdentifier: "pharmacyCell") as! PharmacyOrderCell
            
            pharmacyCell.pharmacyNameLabelOutlet.text = pharmacy?.pharmacyName
            pharmacyCell.pharmacyAddressLabelOutlet.text = pharmacy?.physicalAddress
            
            return pharmacyCell
        default:
            return UITableViewCell()
        }
    }
}

extension ReviewYourOrdedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let viewForHeaderInSection = UIView()
        
        let sectionNameLabel = UILabel()
        sectionNameLabel.text = sectionNames[section]
        sectionNameLabel.textColor = .black
        sectionNameLabel.font = UIFont.boldSystemFont(ofSize: 13)
        sectionNameLabel.frame = CGRect(x: 10, y: 10, width: 100, height: 20)
        
        viewForHeaderInSection.addSubview(sectionNameLabel)
        viewForHeaderInSection.backgroundColor = .white
        
        return viewForHeaderInSection
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNames[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 30
        case 1:
            return 200
        case 2:
            return 30
        case 3:
            return 65
        default:
            return 0
        }
    }
}
