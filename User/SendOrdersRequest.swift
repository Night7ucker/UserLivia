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
//    static func getCheckboxesStatuses() {
//        let url = "https://test.liviaapp.com/api/delivery-men?type=check_price"
//        
//        let headers = [
//            "Content-Type": "application/json",
//            "LiviaApp-Token": RealmDataManager.getTokensFromRealm()[0].accessToken!,
//            "LiviaApp-country": RealmDataManager.getUserDataFromRealm()[0].countryCode!,
//            "LiviaApp-city": RealmDataManager.getUserDataFromRealm()[0].cityId!,
//            "LiviaApp-language": "en",
//            "LiviaApp-timezone": "180",
//            "LiviaApp-APIVersion": "2.0"
//        ]
//        
//        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse
//            <OrderTypeModel>) in
//            OrderTypeModel.writeIntoRealm(response: response)
//            completion(true)
//        }
//    }
    static func findDrugs(completion: @escaping (Bool) -> Void) {
        
        let url = "https://test.liviaapp.com/api/delivery-men?type=check_price"
        
        let headers = [
            "Content-Type": "application/json",
            "LiviaApp-Token": RealmDataManager.getTokensFromRealm()[0].accessToken!,
            "LiviaApp-country": RealmDataManager.getUserDataFromRealm()[0].countryCode!,
            "LiviaApp-city": RealmDataManager.getUserDataFromRealm()[0].cityId!,
            "LiviaApp-language": "en",
            "LiviaApp-timezone": "180",
            "LiviaApp-APIVersion": "2.0"
        ]
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse
            <OrderTypeModel>) in
            OrderTypeModel.writeIntoRealm(response: response)
            completion(true)
        }
        
    }
}
