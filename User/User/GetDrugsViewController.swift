//
//  GetDrugsViewController.swift
//  User
//
//  Created by BAMFAdmin on 27.09.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift



class GetDrugsViewController: RootViewController, UITextFieldDelegate {

    @IBOutlet var drugNameTextFieldOutlet: UITextField!
    
    @IBOutlet var searchLabelOutlet: UILabel!
    @IBOutlet var searchImageOutlet: UIImageView!
    @IBOutlet var drugsListView: UIView!
    @IBOutlet var tableView: UITableView!
    let realm = try! Realm()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if RealmDataManager.getImageUrlFromRealm().count != 0 {
            try! realm.write {
                realm.delete(RealmDataManager.getImageUrlFromRealm())
            }
        }
        
        configureNavigationBar()
        addBackButtonAndTitleToNavigationBar(title: "Search")
        searchImageOutlet.isHidden = false
        searchLabelOutlet.isHidden = false
        drugsListView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        drugNameTextFieldOutlet.delegate = self
        drugNameTextFieldOutlet.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        if(drugNameTextFieldOutlet.text!.characters.count > 2) {
            drugsListView.isHidden = false
            searchImageOutlet.isHidden = true
            searchLabelOutlet.isHidden = true
            let obj = GetDrugsRequest()
            obj.findDrugs(drugName: drugNameTextFieldOutlet.text!, completion: { (success) in
                if success {
                    self.tableView.reloadData()
                }
                
            })

        }
    }
}

extension GetDrugsViewController: UITableViewDataSource {
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return RealmDataManager.getDrugsFromRealm().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drugsCell", for: indexPath) as! DrugsInfoTableViewCell
        
        cell.drugsName.text = RealmDataManager.getDrugsFromRealm()[indexPath.row].name
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedDrugId = RealmDataManager.getDrugsFromRealm()[indexPath.row].id!
        let selectedDrugsObject = DrugsDescriptionRequest()
        selectedDrugsObject.drugsDescription(drugId: selectedDrugId) { (success) in
            if success {
                let drugsDescriptionStoryboard = UIStoryboard(name: "SearchDrugs", bundle: nil)
                let drugsDescriptionVewController = drugsDescriptionStoryboard.instantiateViewController(withIdentifier: "kUserDescriptionStoryboardId") as? DrugInfoViewController
                self.navigationController?.pushViewController(drugsDescriptionVewController!, animated: false)
            }
        }
        
    }
    
}

extension GetDrugsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}

