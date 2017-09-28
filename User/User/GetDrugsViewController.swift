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
    
    @IBOutlet var drugNameButtonOutlet: UIButton!
    var drugId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        drugNameTextFieldOutlet.delegate = self
        drugNameButtonOutlet.isHidden = true
        drugNameTextFieldOutlet.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        if(drugNameTextFieldOutlet.text!.characters.count > 2) {
            drugNameButtonOutlet.isHidden = false
            drugNameButtonOutlet.setTitle(drugNameTextFieldOutlet.text, for: .normal)
            findDrugs()
        }
    }
    
    
    func findDrugs() {
        
        let url = "https://test.liviaapp.com/api/search?search_type=drug"
        
        let parameters: Parameters = [
            "name": drugNameTextFieldOutlet.text!
        ]
        let headers = [
            "Content-Type": "application/json",
            "LiviaApp-language": "en",
            "LiviaApp-APIVersion": "2.0",
            "LiviaApp-Token": "6289faef06329fa14086a8497201a8d17ad23a40"
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            print(response.result.value!)
            guard let result = response.result.value as? [String : AnyObject] else{ return }
            
            guard let tmp = result["body"] as? [[String: AnyObject]] else{ return }
            
            for element in tmp {
                self.drugId = (element["id"] as? String)!
                print(self.drugId)
            }
            
        }
        
    }
 

}
