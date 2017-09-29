//
//  GetDrugsViewController.swift
//  User
//
//  Created by BAMFAdmin on 27.09.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import Alamofire



class GetDrugsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var drugNameTextFieldOutlet: UITextField!
    
    @IBOutlet var drugsListView: UIView!
    @IBOutlet var tableView: UITableView!


    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
    }
    
}

extension GetDrugsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}

