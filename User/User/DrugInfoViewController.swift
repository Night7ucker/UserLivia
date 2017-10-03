//
//  DrugInfoViewController.swift
//  User
//
//  Created by BAMFAdmin on 29.09.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import RealmSwift

protocol DrugNameAndTypeTableViewControllerDelegate {
    func transferDrugsCountAndType(drugsNumber: String)
}

class DrugInfoViewController: RootViewController, DrugNameAndTypeTableViewControllerDelegate {
    
    @IBOutlet var brandNameOutlet: UILabel!
    @IBOutlet var companyOutlet: UILabel!
    @IBOutlet var dosageUnitsOutlet: UILabel!
    @IBOutlet var addToCartOutlet: UIButton!
    @IBOutlet var drugsDescTableView: UITableView!
    @IBOutlet var backToOrderButtonOutlet: UIButton!
    
    @IBOutlet weak var numberOfDrugsLabelOutlet: UILabel!
    
    @IBOutlet weak var popupArrowOutlet: UILabel!
    @IBOutlet weak var drugTypeLabelOutlet: UILabel!
    
    
    var checkDesc = 0
    var checkDosage = 0
    var checkEffects = 0
    var noDrugsData = false
    var checkMoveFromOrder = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        addBackButtonAndTitleToNavigationBar(title: "Item details")
        drugsDescTableView.delegate = self
        drugsDescTableView.dataSource = self
        addToCartOutlet.layer.cornerRadius = 5
        addToCartOutlet.backgroundColor = Colors.Root.lightBlueColor
        backToOrderButtonOutlet.layer.cornerRadius = 5
        backToOrderButtonOutlet.backgroundColor = Colors.Root.lightBlueColor
        drugsDescTableView.estimatedRowHeight = 50
        drugsDescTableView.rowHeight = UITableViewAutomaticDimension
        backToOrderButtonOutlet.isHidden = true
        popupArrowOutlet.textColor = Colors.Root.lightBlueColor
        
        if RealmDataManager.getDrugsDescriptionFromRealm()[0].quantityMeasuring != nil {
            drugTypeLabelOutlet.text = RealmDataManager.getDrugsDescriptionFromRealm()[0].quantityMeasuring!
        }
        
        if checkMoveFromOrder == true {
            addToCartOutlet.isHidden = true
            backToOrderButtonOutlet.isHidden = false
        }
        if RealmDataManager.getDrugsDescriptionFromRealm()[0].brandName != nil {
            brandNameOutlet.text = RealmDataManager.getDrugsDescriptionFromRealm()[0].brandName!
        }
        if RealmDataManager.getDrugsDescriptionFromRealm()[0].manufacturerCompany != nil {
            companyOutlet.text = RealmDataManager.getDrugsDescriptionFromRealm()[0].manufacturerCompany!
        }
        if RealmDataManager.getDrugsDescriptionFromRealm()[0].dosageUnits != nil {
            dosageUnitsOutlet.text = RealmDataManager.getDrugsDescriptionFromRealm()[0].dosageUnits!
        }
        if RealmDataManager.getDrugsDescriptionFromRealm()[0].desc != nil {
            checkDesc = 1
        }
        if RealmDataManager.getDrugsDescriptionFromRealm()[0].dosage != nil {
            checkDosage = 1
        }
        if RealmDataManager.getDrugsDescriptionFromRealm()[0].sideEffects != nil {
            checkEffects = 1
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func backToOrderAction(_ sender: UIButton) {
        let AddToCartStoryboard = UIStoryboard(name: "AddToCart", bundle: nil)
        let AddToCartViewController = AddToCartStoryboard.instantiateViewController(withIdentifier: "kAddToCartStoryboardId") as? AddToCartViewController
        navigationController?.pushViewController(AddToCartViewController!, animated: true)
    }
    
    @IBAction func addToCartAction(_ sender: UIButton) {
        let realm = try! Realm()
        
        if RealmDataManager.getAddedDrugsDataFromRealm().count > 0 {
            if let existingDrugObject = realm.object(ofType: AddedToCartDrugsModel.self, forPrimaryKey: RealmDataManager.getDrugsDescriptionFromRealm()[0].id!) {
                try! realm.write {
                    existingDrugObject.amount += Int(numberOfDrugsLabelOutlet.text!)!
                    realm.add(existingDrugObject, update: true)
                }
            } else {
                addNewDrugIntoRealm()
            }
        } else {
            addNewDrugIntoRealm()
        }
        let AddToCartStoryboard = UIStoryboard(name: "AddToCart", bundle: nil)
        let AddToCartViewController = AddToCartStoryboard.instantiateViewController(withIdentifier: "kAddToCartStoryboardId") as? AddToCartViewController
        navigationController?.pushViewController(AddToCartViewController!, animated: true)
    }
    
    func transferDrugsCountAndType(drugsNumber: String) {
        numberOfDrugsLabelOutlet.text = drugsNumber
    }
    
    func addNewDrugIntoRealm() {
        let addedToCartDrugsObject = AddedToCartDrugsModel()
        addedToCartDrugsObject.amount = Int(numberOfDrugsLabelOutlet.text!)!
        addedToCartDrugsObject.brandName = RealmDataManager.getDrugsDescriptionFromRealm()[0].brandName!
        if RealmDataManager.getDrugsDescriptionFromRealm()[0].quantityMeasuring != nil {
            addedToCartDrugsObject.quantityMeasuring = RealmDataManager.getDrugsDescriptionFromRealm()[0].quantityMeasuring!
        }
        addedToCartDrugsObject.id = RealmDataManager.getDrugsDescriptionFromRealm()[0].id!
        addedToCartDrugsObject.type = RealmDataManager.getDrugsDescriptionFromRealm()[0].type
        RealmDataManager.writeIntoRealm(object: addedToCartDrugsObject)
    }
    
    @IBAction func popupButtonTouched(_ sender: UIButton) {
        let searchDrugsStoryboard = UIStoryboard(name: "SearchDrugs", bundle: nil)
        let drugsNumberAndTypePopupViewController = searchDrugsStoryboard.instantiateViewController(withIdentifier: "kDrugNameAndTypeTableViewController") as? DrugNameAndTypeTableViewController
        drugsNumberAndTypePopupViewController?.delegate = self
        present(drugsNumberAndTypePopupViewController!, animated: false, completion: nil)
    }
}

extension DrugInfoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if checkEffects + checkDosage + checkDesc == 0 {
            noDrugsData = true
            return 1
        }
        return checkEffects + checkDosage + checkDesc
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if noDrugsData {
            let cell = tableView.dequeueReusableCell(withIdentifier: "drugsDescCell", for: indexPath) as! DrugsInfoTableViewCell
            cell.drugsDescLabel.text = "This drug is currently not available in our database, however, kindly indicate the quantity required and make the order and our Chemist partners will be able to assist. Thank you"
            return cell
        }
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "drugsDescCell", for: indexPath) as! DrugsInfoTableViewCell
            cell.drugsDescLabel.text = RealmDataManager.getDrugsDescriptionFromRealm()[0].desc!.uppercased()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "drugsDescCell", for: indexPath) as! DrugsInfoTableViewCell
            cell.drugsDescLabel.text = RealmDataManager.getDrugsDescriptionFromRealm()[0].dosage!.uppercased()
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "drugsDescCell", for: indexPath) as! DrugsInfoTableViewCell
            cell.drugsDescLabel.text = RealmDataManager.getDrugsDescriptionFromRealm()[0].sideEffects!.uppercased()
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}

extension DrugInfoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "DESCRIPTION"
        case 1:
            return "DOSAGE"
        case 2:
            return "SIDE EFFECTS"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Futura", size: 15)!
        header.textLabel?.textColor = UIColor.lightGray
    }
    
}



