//
//  SendOrdersRequest.swift
//  User
//
//  Created by User on 10/3/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import AlamofireObjectMapper
import ObjectMapper_Realm

class SendOrdersRequest {
    static func postRequestToOrderDrugs(completion: @escaping (Bool) -> Void) {
        
        let url = "https://test.liviaapp.com/api/order"
        
        let headers = [
            "Content-Type": "application/json",
            "LiviaApp-Token": RealmDataManager.getTokensFromRealm()[0].accessToken!,
            "LiviaApp-country": RealmDataManager.getUserDataFromRealm()[0].countryCode!,
            "LiviaApp-city": RealmDataManager.getUserDataFromRealm()[0].cityId!,
            "LiviaApp-language": "en",
            "LiviaApp-timezone": "180",
            "LiviaApp-APIVersion": "2.0"
        ]
        
        var drugArray = [[String: String]]()
        
        for drugElement in RealmDataManager.getAddedDrugsDataFromRealm() {
            let drug: [String: String] = [
                "drug_id": drugElement.id!,
                "drug_name": drugElement.brandName!,
                "quantity": String(drugElement.amount),
                "type": String(drugElement.type),
                ]
            drugArray.append(drug)
        }
        
        var parameters: Parameters = [
            "latitude": RealmDataManager.getSendingOrderFromRealm()[0].latitude!,
            "longitude": RealmDataManager.getSendingOrderFromRealm()[0].longtitude!,
            "self-collect": RealmDataManager.getSendingOrderFromRealm()[0].selfCollect!,
            "drugs" : drugArray,
            "manual": RealmDataManager.getSendingOrderFromRealm()[0].manual!,
        ]
        
        if let pharmID = RealmDataManager.getSendingOrderFromRealm()[0].pharmID {
            parameters["pharm_id"] = pharmID
        }
        
        
        
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            completion(true)
        }
        
    }
}
