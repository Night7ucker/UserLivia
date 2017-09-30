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

class GetDrugsRequest {
    func findDrugs(drugName: String, completion: @escaping (Bool) -> Void) {
        
        let realm = try! Realm()
        
        let url = "https://test.liviaapp.com/api/search?search_type=drug"
        let parameters: Parameters = [
            "name": drugName
        ]
        let headers = [
            "Content-Type": "application/json",
            "LiviaApp-language": "en",
            "LiviaApp-country": "ke", //RealmDataManager.getUserDataFromRealm()[0].countryCode!,
            "LiviaApp-city": "200787", //RealmDataManager.getUserDataFromRealm()[0].cityId!,
            "LiviaApp-APIVersion": "2.0" //"LiviaApp-Token": "b7fce82439926f16875339b754db96e6ff8d040a"
            
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            print(response.result.value!)
            guard let result = response.result.value as? [String : AnyObject] else{ return }
            
            guard let body = result["body"] as? [[String: AnyObject]] else{ return }
            
            if RealmDataManager.getDrugsFromRealm().count > 0 {
                try! realm.write {
                    realm.delete(RealmDataManager.getDrugsFromRealm())
                }
            }
            for element in body {
                let getDrugsObject = GetDrugsModel()
                getDrugsObject.id = element["id"] as? String
                getDrugsObject.name = element["name"] as? String
                getDrugsObject.type = (element["type"] as? Int)!
                RealmDataManager.writeIntoRealm(object: getDrugsObject)
            }
            completion(true)
            
        }
        
    }
}

