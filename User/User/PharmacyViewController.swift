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
    
    var test: Results<Pharmacy>? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        pharmaciesTableViewOutlet.delegate = self
        pharmaciesTableViewOutlet.dataSource = self
        
        view.backgroundColor = Colors.Root.lightGrayColor
        pharmaciesTableViewOutlet.tableFooterView = UIView(frame: .zero)
        pharmaciesTableViewOutlet.backgroundColor = Colors.Root.lightGrayColor
        pharmacySearchTextFieldOutlet.backgroundColor = Colors.Root.lightGrayColor
        searchViewOutlet.backgroundColor = Colors.Root.lightGrayColor
        
        test = RealmDataManager.getPharmaciesFromRealm()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func choosePharmacyButtonTapped(_ sender: UIButton) {
        
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
        
        if test?.count != 0 {
//            getImage(pictureUrl: test[indexPath.row]., onCompletion: <#T##(Bool, UIImage?) -> Void#>)
            pharmacyCell.pharmacyPictureImageViewOutlet.image = UIImage(named: "bellPicture")
            pharmacyCell.pharmacyNameLabelOutlet.text = test?[indexPath.row].pharmacyName
            pharmacyCell.pharmacyAddressLabelOutlet.text = test?[indexPath.row].physicalAddress
            pharmacyCell.pharmacyDayWorkingLabelOutlet.text = test?[indexPath.row].workTime
        }
        
        
        
        return pharmacyCell
    }
}

extension PharmacyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89
    }
}
