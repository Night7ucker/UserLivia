//
//  PharmacyViewController.swift
//  User
//
//  Created by User on 10/3/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class PharmacyViewController: RootViewController {
    
    
    @IBOutlet weak var pharmacySearchTextFieldOutlet: UITextField!
    @IBOutlet weak var pharmaciesTableViewOutlet: UITableView!
    
    @IBOutlet weak var searchViewOutlet: UIView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        pharmaciesTableViewOutlet.delegate = self
        pharmaciesTableViewOutlet.dataSource = self
        
        view.backgroundColor = Colors.Root.lightGrayColor
        pharmaciesTableViewOutlet.tableFooterView = UIView(frame: .zero)
        pharmaciesTableViewOutlet.backgroundColor = Colors.Root.lightGrayColor
        pharmacySearchTextFieldOutlet.backgroundColor = Colors.Root.lightGrayColor
        searchViewOutlet.backgroundColor = Colors.Root.lightGrayColor
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
        
        pharmacyCell.pharmacyPictureImageViewOutlet.image = UIImage(named: "bellPicture")
        pharmacyCell.pharmacyNameLabelOutlet.text = "Test"
        pharmacyCell.pharmacyAddressLabelOutlet.text = "Golodeda 17"
        pharmacyCell.pharmacyDayWorkingLabelOutlet.text = "24/7"
        
        return pharmacyCell
    }
}

extension PharmacyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89
    }
}
