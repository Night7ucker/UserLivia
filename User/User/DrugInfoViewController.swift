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
 
    @IBOutlet var descriptionOutlet: UITextView!
    @IBOutlet var dosageUnitsOutlet: UILabel!
    
    @IBOutlet var addToCartOutlet: UIButton!
    @IBOutlet var sideEffectsOutlet: UITextView!
    @IBOutlet var dosageOutlet: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        addBackButtonAndTitleToNavigationBar(title: "Item details")
        
        brandNameOutlet.isHidden = true
        companyOutlet.isHidden = true
        descriptionOutlet.isHidden = true
        sideEffectsOutlet.isHidden = true
        dosageOutlet.isHidden = true
        dosageUnitsOutlet.isHidden = true
        
        if RealmDataManager.getDrugsDescriptionFromRealm()[0].brandName != nil {
            brandNameOutlet.text = RealmDataManager.getDrugsDescriptionFromRealm()[0].brandName!
            brandNameOutlet.isHidden = false
        }
        if RealmDataManager.getDrugsDescriptionFromRealm()[0].manufacturerCompany != nil {
            companyOutlet.text = RealmDataManager.getDrugsDescriptionFromRealm()[0].manufacturerCompany!
            companyOutlet.isHidden = false
        }
        if RealmDataManager.getDrugsDescriptionFromRealm()[0].desc != nil {
            descriptionOutlet.text = RealmDataManager.getDrugsDescriptionFromRealm()[0].desc!.uppercased()
            descriptionOutlet.isHidden = false
        }
        if RealmDataManager.getDrugsDescriptionFromRealm()[0].sideEffects != nil {
            sideEffectsOutlet.text = RealmDataManager.getDrugsDescriptionFromRealm()[0].sideEffects!.uppercased()
            sideEffectsOutlet.isHidden = false
        }
        if RealmDataManager.getDrugsDescriptionFromRealm()[0].dosageUnits != nil {
            dosageUnitsOutlet.text = RealmDataManager.getDrugsDescriptionFromRealm()[0].dosageUnits!
            dosageUnitsOutlet.isHidden = false
        }
        if RealmDataManager.getDrugsDescriptionFromRealm()[0].dosage != nil {
            dosageOutlet.text = RealmDataManager.getDrugsDescriptionFromRealm()[0].dosage!.uppercased()
            dosageOutlet.isHidden = false
        }
        addToCartOutlet.layer.cornerRadius = 5
        addToCartOutlet.backgroundColor = Colors.Root.lightBlueColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func addToCartAction(_ sender: UIButton) {
    }

}
