//
//  File.swift
//  User
//
//  Created by BAMFAdmin on 03.10.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//


import Foundation
import ObjectMapper
import Alamofire
import RealmSwift
import ObjectMapper_Realm

class OrdersCountModel: Object, Mappable{
    
    dynamic var allEvents = -1
    dynamic var allOrders = -1
    dynamic var eventsPendingAction = -1
    dynamic var openOrders = -1
    dynamic var ordersPendingAction = -1

    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        allEvents <- map["count_all_events"]
        allOrders <- map["count_all_orders"]
        eventsPendingAction <- map["count_events_pending_action"]
        openOrders <- map["count_open_orders"]
        ordersPendingAction <- map["count_orders_pending_action"]
    }
    
    static func writeIntoRealm(response: DataResponse<OrdersCountModel>){
        let result = response.result.value!
        let realm = try! Realm()
        if RealmDataManager.getOrdersCountFromRealm().count != 0 {
            try! realm.write {
                realm.delete(RealmDataManager.getOrdersCountFromRealm())
            }
        }
        try! realm.write {
            realm.add(result)
        }
    }
    
}
