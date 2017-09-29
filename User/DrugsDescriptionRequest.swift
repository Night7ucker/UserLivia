//
//  GetDrugsRequest.swift
//  User
//
//  Created by BAMFAdmin on 29.09.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire

class DrugsDescriptionRequest {
    func drugsDescription(drugId:String, completion: @escaping (Bool) -> Void) {
        
        let realm = try! Realm()
        
        let url = "https://test.liviaapp.com/api/drug/"+drugId+"?type=1"
       
        let headers = [
            "Content-Type": "application/json",
            "LiviaApp-language": "en",
            "LiviaApp-country": "ke", //RealmDataManager.getUserDataFromRealm()[0].countryCode!,
            "LiviaApp-city": "200787", //RealmDataManager.getUserDataFromRealm()[0].cityId!,
            "LiviaApp-APIVersion": "2.0",
            "LiviaApp-timezone": "180",
            "LiviaApp-Token": "b7fce82439926f16875339b754db96e6ff8d040a"
        ]
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            print(response.result.value!)
            
            if RealmDataManager.getDrugsDescriptionFromRealm().count > 0 {
                try! realm.write {
                    realm.delete(RealmDataManager.getDrugsDescriptionFromRealm())
                }
            }
            guard let result = response.result.value as? [String : AnyObject] else{ return }
            let drugsDescriptionObject = DrugsDescriptionModel()
            drugsDescriptionObject.id = result["id"] as? String
            drugsDescriptionObject.type = (result["type"] as? Int)!
            drugsDescriptionObject.brandName = result["brand_name"] as? String
            drugsDescriptionObject.contraindications = result["contraindications"] as? String
            drugsDescriptionObject.desc = result["description"] as? String
            drugsDescriptionObject.dosage = result["dosage"] as? String
            drugsDescriptionObject.dosageUnits = result["dosage_units"] as? String
            drugsDescriptionObject.manufacturerCompany = result["manufacturer_company"] as? String
            drugsDescriptionObject.sideEffects = result["side_effects"] as? String 
            drugsDescriptionObject.name = result["name"] as? String
            RealmDataManager.writeIntoRealm(object: drugsDescriptionObject, realm: realm)
            completion(true)
        }
        
    }
}

