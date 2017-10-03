//
//  OrderListRequest.swift
//  User
//
//  Created by BAMFAdmin on 03.10.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import AlamofireObjectMapper
import ObjectMapper_Realm

class OrdersCountRequest {
    static func getOrdersList(completion: @escaping (Bool) -> Void) {
        
        let url = "https://test.liviaapp.com/api/order-statistics"
        
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
            <OrdersCountModel>) in
            OrdersCountModel.writeIntoRealm(response: response)
            completion(true)
        }
    }
}
