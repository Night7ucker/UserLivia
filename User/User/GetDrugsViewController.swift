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



class GetDrugsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var drugNameTextFieldOutlet: UITextField!
    
    @IBOutlet var drugsListView: UIView!
    @IBOutlet var tableView: UITableView!
    let realm = try! Realm()

    
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
        titleLabel.text = "Search"
        titleLabel.textColor = .white
        titleLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        let titleLabelBarButton = UIBarButtonItem(customView: titleLabel)
        
        navigationItem.setLeftBarButtonItems([backButtonBarButton, titleLabelBarButton], animated: true)
        
        drugsListView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        drugNameTextFieldOutlet.delegate = self
        drugNameTextFieldOutlet.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        if(drugNameTextFieldOutlet.text!.characters.count > 2) {
            drugsListView.isHidden = false
            let obj = GetDrugsRequest()
            obj.findDrugs(drugName: drugNameTextFieldOutlet.text!, completion: { (success) in
                if success {
                    self.tableView.reloadData()
                }
                
            })

        }
    }
    func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
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

