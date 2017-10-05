//
//  PaymentRequest.swift
//  User
//
//  Created by User on 10/5/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import AlamofireObjectMapper
import ObjectMapper_Realm

class PaymentRequest {
    static func payForOrder(orderID: String, completion: @escaping (Bool) -> Void) {
        
        let url = "https://test.liviaapp.com/api/order/" + orderID
        
        let parameters: Parameters = [
            "amount": String(RealmDataManager.getOrderDrugsDescriptionModel()[0].drugPrice),
            "pay_type": "cash"
        ]
        
        let headers = [
            "Content-Type": "application/json",
            "LiviaApp-Token": RealmDataManager.getTokensFromRealm()[0].accessToken!,
            "LiviApp-country": RealmDataManager.getUserDataFromRealm()[0].countryCode!,
            "LiviaApp-city": RealmDataManager.getUserDataFromRealm()[0].cityId!,
            "LiviaApp-language": "en",
            "LiviaApp-timezone": "180",
            "LiviaApp-APIVersion": "2.0"
        ]
        
        
        
        Alamofire.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            print(response.result.value)
            completion(true)
        }
    }
}



