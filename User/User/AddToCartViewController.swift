//
//  AddToCartViewController.swift
//  User
//
//  Created by BAMFAdmin on 02.10.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import RealmSwift

class AddToCartViewController:RootViewController, DrugNameAndTypeTableViewControllerDelegate, SigninViewControllerDelegate {

    @IBOutlet var addDrugButtonOutlet: UIButton!
    @IBOutlet var requestPriceButtonOutlet: UIButton!
    
    @IBOutlet var addToCartTableView: UITableView!
    
    @IBOutlet var deleteDrugButtonOutlet: UIButton!
    
    var indexPathOfCellToChangeDrugsNumber: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        addBackButtonAndTitleToNavigationBar(title: "Cart")
        addDrugButtonOutlet.layer.cornerRadius = 5
        addDrugButtonOutlet.backgroundColor = Colors.Root.lightBlueColor
        requestPriceButtonOutlet.layer.cornerRadius = 5
        requestPriceButtonOutlet.backgroundColor = Colors.Root.lightBlueColor
        addToCartTableView.dataSource = self
        addToCartTableView.tableFooterView = UIView(frame: .zero)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func deleteDrugAction(_ sender: UIButton) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.addToCartTableView)
        let indexPath = self.addToCartTableView.indexPathForRow(at: buttonPosition)!

        let realm = try! Realm()
        try! realm.write {
            realm.delete(RealmDataManager.getAddedDrugsDataFromRealm()[indexPath.last!])
        }
        addToCartTableView.reloadData()
        

    }
    @IBAction func getDrugInfoAction(_ sender: UIButton) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.addToCartTableView)
        let indexPath = self.addToCartTableView.indexPathForRow(at: buttonPosition)!
        let selectedDrugId = RealmDataManager.getAddedDrugsDataFromRealm()[indexPath.last!].id!
        let selectedDrugsObject = DrugsDescriptionRequest()
        selectedDrugsObject.drugsDescription(drugId: selectedDrugId) { (success) in
            if success {
                let drugsDescriptionStoryboard = UIStoryboard(name: "SearchDrugs", bundle: nil)
                let drugsDescriptionVewController = drugsDescriptionStoryboard.instantiateViewController(withIdentifier: "kUserDescriptionStoryboardId") as? DrugInfoViewController
                drugsDescriptionVewController?.checkMoveFromOrder = true
                self.navigationController?.pushViewController(drugsDescriptionVewController!, animated: false)
            }
        }
        
    }
    
    @IBAction func addDrugAction(_ sender: UIButton) {
        let GetDrugsStoryboard = UIStoryboard(name: "SearchDrugs", bundle: nil)
        let GetDrugsViewController = GetDrugsStoryboard.instantiateViewController(withIdentifier: "kSearchDrugsStoryboardId") as? GetDrugsViewController
        navigationController?.pushViewController(GetDrugsViewController!, animated: true)

    }
    
    @IBAction func RequestPriceAction(_ sender: UIButton) {
        if RealmDataManager.getTokensFromRealm().count != 0 {
            let selectOrderTypeStoryboard = UIStoryboard(name: "SelectOrderType", bundle: nil)
            let selectOrderTypeViewController = selectOrderTypeStoryboard.instantiateViewController(withIdentifier: "kExpandedViewController") as? ExpandedViewController
            navigationController?.pushViewController(selectOrderTypeViewController!, animated: false)
        } else {
            let signinViewStoryboard = UIStoryboard(name: "SigninViewStoryboard", bundle: nil)
            let signinViewController = signinViewStoryboard.instantiateViewController(withIdentifier: "kSigninViewController") as? SigninViewController
            signinViewController?.delegate = self
            present(signinViewController!, animated: false, completion: nil)
        }
    }
    

    @IBAction func drugNumberPopupTapped(_ sender: UIButton) {
        let buttonPosition: CGPoint = sender.convert(CGPoint.zero, to:self.addToCartTableView)
        let indexPath = self.addToCartTableView.indexPathForRow(at: buttonPosition)!
        indexPathOfCellToChangeDrugsNumber = indexPath
        
        let searchDrugsStoryboard = UIStoryboard(name: "SearchDrugs", bundle: nil)
        let drugsNumberAndTypePopupViewController = searchDrugsStoryboard.instantiateViewController(withIdentifier: "kDrugNameAndTypeTableViewController") as? DrugNameAndTypeTableViewController
        drugsNumberAndTypePopupViewController?.delegate = self
        drugsNumberAndTypePopupViewController?.whereToShow = buttonPosition
        present(drugsNumberAndTypePopupViewController!, animated: false, completion: nil)
    }
    
    func transferDrugsCountAndType(drugsNumber: String) {
        let cell = addToCartTableView.cellForRow(at: indexPathOfCellToChangeDrugsNumber) as! AddToCartTableViewCell
        cell.amountLabel.text = drugsNumber
        let realm = try! Realm()
        try! realm.write {
            RealmDataManager.getAddedDrugsDataFromRealm()[indexPathOfCellToChangeDrugsNumber.row].amount = Int(drugsNumber)!
        }
    }
    
    func pushToRegistrationViewController() {
        let mainViewStoryboard = UIStoryboard(name: "MainViewsStoryboard", bundle: nil)
        let registrationViewController = mainViewStoryboard.instantiateViewController(withIdentifier: "kRegistrationViewController") as? RegistrationViewController
        navigationController?.pushViewController(registrationViewController!, animated: false)
    }
}

extension AddToCartViewController: UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RealmDataManager.getAddedDrugsDataFromRealm().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addToCartCell", for: indexPath) as! AddToCartTableViewCell
        cell.nameOfMedicineLabel.text = RealmDataManager.getAddedDrugsDataFromRealm()[indexPath.row].brandName!
        cell.amountLabel.text = String(describing: RealmDataManager.getAddedDrugsDataFromRealm()[indexPath.row].amount)
        if let test = RealmDataManager.getAddedDrugsDataFromRealm()[indexPath.row].quantityMeasuring {
            cell.drugQuantityMeasureOutlet.text = test
        }

        
        
        return cell
        
        }
    
}
