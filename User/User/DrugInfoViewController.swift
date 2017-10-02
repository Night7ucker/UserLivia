//
//  DrugInfoViewController.swift
//  User
//
//  Created by BAMFAdmin on 29.09.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class DrugInfoViewController: RootViewController {

    @IBOutlet var brandNameOutlet: UILabel!
    @IBOutlet var companyOutlet: UILabel!
    @IBOutlet var dosageUnitsOutlet: UILabel!
    @IBOutlet var addToCartOutlet: UIButton!
    @IBOutlet var drugsDescTableView: UITableView!
 
    var checkDesc = 0
    var checkDosage = 0
    var checkEffects = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        addBackButtonAndTitleToNavigationBar(title: "Item details")
        drugsDescTableView.delegate = self
        drugsDescTableView.dataSource = self
        brandNameOutlet.text = RealmDataManager.getDrugsDescriptionFromRealm()[0].brandName!
        companyOutlet.text = RealmDataManager.getDrugsDescriptionFromRealm()[0].manufacturerCompany!
        dosageUnitsOutlet.text = RealmDataManager.getDrugsDescriptionFromRealm()[0].dosageUnits!

        if RealmDataManager.getDrugsDescriptionFromRealm()[0].desc != nil {
            checkDesc = 1
        }
        if RealmDataManager.getDrugsDescriptionFromRealm()[0].dosage != nil {
            checkDosage = 1
        }
        if RealmDataManager.getDrugsDescriptionFromRealm()[0].sideEffects != nil {
            checkEffects = 1
        }
        addToCartOutlet.layer.cornerRadius = 5
        addToCartOutlet.backgroundColor = Colors.Root.lightBlueColor
        self.drugsDescTableView.estimatedRowHeight = 280
        self.drugsDescTableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func addToCartAction(_ sender: UIButton) {
        let AddToCartStoryboard = UIStoryboard(name: "AddToCart", bundle: nil)
        let AddToCartViewController = AddToCartStoryboard.instantiateViewController(withIdentifier: "kAddToCartStoryboardId") as? AddToCartViewController
        navigationController?.pushViewController(AddToCartViewController!, animated: true)
    }

}

extension DrugInfoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return checkEffects + checkDosage + checkDesc

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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



