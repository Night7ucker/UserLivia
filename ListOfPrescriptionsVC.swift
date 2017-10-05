//
//  ListOfPrescriptionsVC.swift
//  User
//
//  Created by User on 10/5/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import RealmSwift

class ListOfPrescriptionsVC: RootViewController {
    
    @IBOutlet weak var listOfPrescriptionsTableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if RealmDataManager.getPrescriptionListModel().count != 0 {
            let realm = try! Realm()
            try! realm.write {
                realm.delete(RealmDataManager.getPrescriptionListModel())
            }
        }
        
        configureNavigationBar()
        addBackButtonAndTitleToNavigationBar(title: "List of Prescriptions")
        
        listOfPrescriptionsTableViewOutlet.dataSource = self
        listOfPrescriptionsTableViewOutlet.delegate = self
        
        listOfPrescriptionsTableViewOutlet.tableFooterView = UIView(frame: .zero)
        
        PrescriptionListRequest.getPrescriptionList { success in
            if success {
                self.listOfPrescriptionsTableViewOutlet.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension ListOfPrescriptionsVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RealmDataManager.getPrescriptionListModel().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let prescriptionCell = tableView.dequeueReusableCell(withIdentifier: "prescriptionCell") as! PrescriptionCell
        let dateString = RealmDataManager.getPrescriptionListModel()[indexPath.row].createDate?.components(separatedBy: "T")[0]
        let firstString = (dateString?.components(separatedBy: "-")[2])! + "."
        let secondString = dateString?.components(separatedBy: "-")[1]
        let thirdString = "." + (dateString?.components(separatedBy: "-")[0])!
        let finalString = firstString + secondString! + thirdString
        prescriptionCell.prescriptionDateLabelOutlet.text = finalString
        
        let imageURL = "https://test.liviaapp.com" + RealmDataManager.getPrescriptionListModel()[indexPath.row].image!
        getImage(pictureUrl: imageURL) { success, image in
            if success {
                prescriptionCell.prescriptionImageViewOutlet.image = image
            }
        }
        
        return prescriptionCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listOfPrescriptionsStoryboard = UIStoryboard(name: "ListOfPrescriptions", bundle: nil)
        let showPhotoViewController = listOfPrescriptionsStoryboard.instantiateViewController(withIdentifier: "kShowPhotoViewController") as! ShowPhotoViewController
        showPhotoViewController.indexOfSelectedCell = indexPath.row
        navigationController?.pushViewController(showPhotoViewController, animated: false)
    }
}

extension ListOfPrescriptionsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
