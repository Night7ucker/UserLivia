//
//  PopupCountryCodesTableViewController.swift
//  User
//
//  Created by User on 9/22/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import CoreGraphics
import RealmSwift

class PopupCountryCodesTableViewController: RootViewController{
    
    @IBOutlet weak var countryCodesTableView: UITableView!
    
    let countryCodeDataManagerObject = GetCountryCodesRequest()
    
    var array:[RealmDataManager] = []
    
    var delegate: PopupCountryCodesTableViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.countryCodesTableView.layer.cornerRadius = 5
        self.countryCodesTableView.indicatorStyle = .default

        countryCodesTableView.delegate = self
        countryCodesTableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
 }

extension PopupCountryCodesTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RealmDataManager.getDataFromCountries().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCodeCell", for: indexPath) as! CountryCodeCell
        
        cell.fillCellInfo(countryName: RealmDataManager.getDataFromCountries()[indexPath.row].countryName!, countryCode: "+" + RealmDataManager.getDataFromCountries()[indexPath.row].phoneCode!)
        
        let urlImage = "https://test.liviaapp.com" + RealmDataManager.getDataFromCountries()[indexPath.row].countryFlag!
        getImage(pictureUrl: urlImage) { success, image in
            if success {
                cell.countryFlagImageViewOutlet.image = image
            }
        }
        return cell
    }
}

extension PopupCountryCodesTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.sendCountryInfo(index: indexPath.row)
        
        dismiss(animated: false, completion: nil)
    }
}
