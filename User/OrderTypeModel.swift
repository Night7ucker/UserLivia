//
//  OrderTypeRequest.swift
//  User
//
//  Created by User on 10/3/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import RealmSwift
import ObjectMapper_Realm

class OrderTypeModel: Object, Mappable{
    
    dynamic var drugCurrency: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        drugCurrency <- map["delivery_price"]
    }
    
    static func writeIntoRealm(response: DataResponse<OrderTypeModel>){
        let result = response.result.value!
        let realm = try! Realm()
        if RealmDataManager.getDeliveryPriceForDrug().count != 0 {
            try! realm.write {
                realm.delete(RealmDataManager.getDeliveryPriceForDrug())
            }
        }
        try! realm.write {
            realm.add(result)
        }
    }
    
}
