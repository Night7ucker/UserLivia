//
//  SendOrdersModel.swift
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

class SendOrdersModel: Object, Mappable{
    
    dynamic var drugCurrency: String?
    dynamic var latitude: String?
    dynamic var longtitude: String?
    dynamic var selfCollect: String?
    dynamic var manual: String?
    dynamic var pharmID: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        drugCurrency <- map["delivery_price"]
    }
    
    static func writeIntoRealm(response: DataResponse<SendOrdersModel>){
        let result = response.result.value!
        let realm = try! Realm()
        if RealmDataManager.getSendingOrderFromRealm().count != 0 {
            try! realm.write {
                realm.delete(RealmDataManager.getSendingOrderFromRealm())
            }
        }
        try! realm.write {
            realm.add(result)
        }
    }
    
}
