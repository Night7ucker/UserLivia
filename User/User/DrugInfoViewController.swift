//
//  DrugInfoViewController.swift
//  User
//
//  Created by BAMFAdmin on 29.09.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class DrugInfoViewController: UIViewController {

    @IBOutlet var brandNameOutlet: UILabel!
    @IBOutlet var companyOutlet: UILabel!
 
    @IBOutlet var descriptionOutlet: UITextView!
    @IBOutlet var dosageUnitsOutlet: UILabel!
    
    @IBOutlet var addToCartOutlet: UIButton!
    @IBOutlet var sideEffectsOutlet: UITextView!
    @IBOutlet var dosageOutlet: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.4, green: 0.8, blue: 0.7, alpha: 1)
        
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        navigationController?.navigationBar.layer.shadowRadius = 4.0
        navigationController?.navigationBar.layer.shadowOpacity = 0.5
        navigationController?.navigationBar.layer.masksToBounds = false
        
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        backButton.setTitle("", for: .normal)
        
        backButton.setBackgroundImage(UIImage(named: "backButtonImage"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        
        let backButtonBarButton = UIBarButtonItem(customView: backButton)
        
        let titleLabel = UILabel()
        titleLabel.text = "Item details"
        titleLabel.textColor = .white
        titleLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        let titleLabelBarButton = UIBarButtonItem(customView: titleLabel)
        
        navigationItem.setLeftBarButtonItems([backButtonBarButton, titleLabelBarButton], animated: true)
        
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
        addToCartOutlet.backgroundColor = UIColor(red: CGFloat(121/255.0), green: CGFloat(181/255.0), blue: CGFloat(208/255.0), alpha: CGFloat(1.0))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addToCartAction(_ sender: UIButton) {
    }

    func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }

}
