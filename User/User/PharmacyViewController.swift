//
//  PharmacyViewController.swift
//  User
//
//  Created by User on 10/3/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import RealmSwift

class PharmacyViewController: RootViewController {
    
    
    @IBOutlet weak var pharmacySearchTextFieldOutlet: UITextField!
    @IBOutlet weak var pharmaciesTableViewOutlet: UITableView!
    
    @IBOutlet weak var searchViewOutlet: UIView!
    
    var delegate: GoogleMapViewControllerDelegate!
    var pharmaciesArray: Results<Pharmacy>? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        pharmaciesTableViewOutlet.delegate = self
        pharmaciesTableViewOutlet.dataSource = self
        
        view.backgroundColor = Colors.Root.lightGrayColor
        pharmaciesTableViewOutlet.tableFooterView = UIView(frame: .zero)
        pharmaciesTableViewOutlet.backgroundColor = Colors.Root.lightGrayColor
        pharmacySearchTextFieldOutlet.backgroundColor = Colors.Root.lightGrayColor
        searchViewOutlet.backgroundColor = Colors.Root.lightGrayColor
        
        pharmaciesArray = RealmDataManager.getPharmaciesFromRealm()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func choosePharmacyButtonTapped(_ sender: UIButton) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:pharmaciesTableViewOutlet)
        let indexPath = pharmaciesTableViewOutlet.indexPathForRow(at: buttonPosition)!
        
        delegate.pushToReviewOrderVC(pharmacyID: RealmDataManager.getPharmaciesFromRealm()[indexPath[1]].userId!)
    }
}

extension PharmacyViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pharmacyCell = tableView.dequeueReusableCell(withIdentifier: "pharmacyCell") as! PharmacyTableViewCell
        
        if pharmaciesArray?.count != 0 {
            pharmacyCell.pharmacyNameLabelOutlet.text = pharmaciesArray?[indexPath.row].pharmacyName
            pharmacyCell.pharmacyAddressLabelOutlet.text = pharmaciesArray?[indexPath.row].physicalAddress
            pharmacyCell.pharmacyDayWorkingLabelOutlet.text = pharmaciesArray?[indexPath.row].workTime
            pharmacyCell.idButtonHiddenOutlet.text = pharmaciesArray?[indexPath.row].userId
        }
        
        return pharmacyCell
    }
}

extension PharmacyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89
    }
}
