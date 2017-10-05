//
//  GetOrderDescriptionRequest.swift
//  User
//
//  Created by BAMFAdmin on 04.10.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import AlamofireObjectMapper


class GetOrderDescriptionRequest{
    
    static func getOrderDescription(orderId: String, completion: @escaping (Bool) -> Void)  {
        
        let url = "https://test.liviaapp.com/api/order/"+orderId
        
        let headers = [
            "Content-Type": "application/json",
            "LiviaApp-language": "en",
            "LiviaApp-timezone": "180",
            "LiviaApp-city": RealmDataManager.getUserDataFromRealm()[0].cityId!,
            "LiviaApp-country": RealmDataManager.getUserDataFromRealm()[0].countryId!,
            "LiviaApp-APIVersion": "2.0",
            "LiviaApp-Token": RealmDataManager.getTokensFromRealm()[0].accessToken!
        ]
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            print(response.result.value)
            guard let result = response.result.value as? [String : AnyObject] else{ return }
            let checkForImage = result["image"] as? String
            if checkForImage != nil {
                let orderDescObject = OrderDescriptionModelImage()
                orderDescObject.imageUrl = result["image"] as? String
                orderDescObject.selfCollect = result["self_collect"] as? String
                RealmDataManager.writeIntoRealm(object: orderDescObject)
            } else {
                
                let array = result["drugs"] as? [[String: AnyObject]]
                for element in array! {
                    let orderDescObject = OrderDescriptionModel()
                    orderDescObject.drugName = element["drug_name"] as? String
                    orderDescObject.quantity = element["quantity"] as? String
                    orderDescObject.quantityMeasuring = element["quantity_measuring"] as? String
                    orderDescObject.selfCollect = result["self_collect"] as? String
                    RealmDataManager.writeIntoRealm(object: orderDescObject)
                }

            }
         completion(true)
        }
     
    }
}
