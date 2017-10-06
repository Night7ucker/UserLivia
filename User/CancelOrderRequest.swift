//
//  CancelOrderRequest.swift
//  User
//
//  Created by User on 10/6/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class CancelOrderRequest {
    
    static func deleteReminder(orderID: String, cancelReason: String) {
        
        let url = "https://test.liviaapp.com/api/order/" + orderID + "?reason_cancel=" + cancelReason + "&reason_text="
        let headers = [
            "LiviaApp-Token": RealmDataManager.getTokensFromRealm()[0].accessToken!,
            "LiviApp-country": RealmDataManager.getUserDataFromRealm()[0].countryCode!,
            "LiviaApp-city": RealmDataManager.getUserDataFromRealm()[0].cityId!,
            "LiviaApp-language": "en",
            "LiviaApp-timezone": "180",
            "LiviaApp-APIVersion": "2.0"
        ]
        
        
        Alamofire.request(url, method: .delete, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            print(response.result.value)
        }
    }

}
