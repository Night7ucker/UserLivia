//
//  GetDrugsRequest.swift
//  User
//
//  Created by BAMFAdmin on 29.09.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import AlamofireObjectMapper

class DrugsDescriptionRequest {
    func drugsDescription(drugId:String, completion: @escaping (Bool) -> Void) {
        
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
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse
            <DrugsDescriptionModel>) in
            DrugsDescriptionModel.writeIntoRealm(response: response)
            completion(true)
        }
        
    }
}

