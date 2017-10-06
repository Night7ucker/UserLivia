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
            let realm = try! Realm()
            if RealmDataManager.getOrderDescriptionModel().count > 0 {
                try! realm.write {
                    realm.delete(RealmDataManager.getOrderDescriptionModel())
                }
            }
            if RealmDataManager.getOrderDrugsDescriptionModel().count > 0 {
                try! realm.write {
                    realm.delete(RealmDataManager.getOrderDrugsDescriptionModel())
                }
            }
            print(response.result.value)
            guard let result = response.result.value as? [String : AnyObject] else{ return }
            let checkForImage = result["image"] as? String
            if checkForImage != nil {
                let orderDescObjectImage = OrderDescriptionModelImage()
                orderDescObjectImage.imageUrl = result["image"] as? String
                orderDescObjectImage.selfCollect = result["self_collect"] as? String
                RealmDataManager.writeIntoRealm(object: orderDescObjectImage)

       
    
                } else {
                let orderDescObject = OrderDescriptionModel()
                orderDescObject.deliveryCost = result["delivery_cost"] as? String
                orderDescObject.orderId = result["order_id"] as? String
                orderDescObject.selfCollect = result["self_collect"] as? String
                orderDescObject.totatPrice = result["total_price"] as? String
                orderDescObject.totalDrugsPrice = result["total_price_drugs"] as? String
                orderDescObject.statusId = result["status_id"] as? String
                RealmDataManager.writeIntoRealm(object: orderDescObject)

                let array = result["drugs"] as? [[String: AnyObject]]
                for element in array! {
                   let orderDrugDescObject = OrderDrugsDescriptionModel()
                    orderDrugDescObject.drugName = element["drug_name"] as? String
                    orderDrugDescObject.drugId = element["drug_id"] as? String
                    orderDrugDescObject.pAdmin = element["admin_name"] as? String
                    orderDrugDescObject.pLat = element["latitude"] as? String
                    orderDrugDescObject.pLong = element["longitude"] as? String
                    orderDrugDescObject.pId = element["pharmacy_id"] as? String
                    orderDrugDescObject.pNumber = element["phone_number"] as? String
                    orderDrugDescObject.pName = element["pharmacy_name"] as? String
                    orderDrugDescObject.quantity = element["quantity"] as? String
                    orderDrugDescObject.quantityMeasuring = element["quantity_measuring"] as? String
                    orderDrugDescObject.activeItem = element["active_item"] as? String
                    if let _ = element["price"] {
                        orderDrugDescObject.drugPrice = element["price"] as! Int
                    }


                    RealmDataManager.writeIntoRealm(object: orderDrugDescObject)
                }
            }
         completion(true)
        }
     
    }
}
