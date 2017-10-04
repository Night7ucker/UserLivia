//
//  PharmacyInfoViewController.swift
//  User
//
//  Created by User on 10/4/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import RealmSwift

class PharmacyInfoViewController: RootViewController {

    
    
    @IBOutlet weak var pharmacyNameLabelOutlet: UILabel!
    
    @IBOutlet weak var pharmacyAddressLabelOutlet: UILabel!
    @IBOutlet weak var choosePharmacyButtonOutlet: UIButton!
    
    @IBOutlet weak var popupViewOutlet: UIView!
    
    var delegate: PharmacyInfoViewControllerDelegate!
    var tappedPharmacyId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let pharmaciesArray = RealmDataManager.getPharmaciesFromRealm()
        for pharmacy in pharmaciesArray {
            if pharmacy.userId == tappedPharmacyId {
                pharmacyAddressLabelOutlet.text = pharmacy.physicalAddress
                pharmacyNameLabelOutlet.text = pharmacy.pharmacyName
            }
        }
        
        popupViewOutlet.layer.cornerRadius = 1
        choosePharmacyButtonOutlet.setTitleColor(Colors.Root.greenColorForNavigationBar, for: .normal)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
   
    @IBAction func choosePharmacyButtonTapped(_ sender: UIButton) {
        dismiss(animated: false) {
            self.delegate.sentDelegateToPushToMainPageController(pharmacyID: self.tappedPharmacyId!)
        }
    }

}
