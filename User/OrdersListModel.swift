//
//  OrdersListModel.swift
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

class MappedOrdersListModel: Mappable {
    var ordersListModelArray: [OrdersListModel]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        ordersListModelArray <- map["body"]
    }
    
    static func writeIntoRealm(response: DataResponse<MappedOrdersListModel>){
        let result = response.result.value
        let realm = try! Realm()
        if let array = result?.ordersListModelArray {
            for element in array {
                try! realm.write {
                    realm.add(element)
                }
            }
        }
    }
}

class OrdersListModel: Object, Mappable {
    dynamic var orderId: String?
    dynamic var createDate: String?
    dynamic var statusId: String?
    dynamic var selfCollect: String?
    dynamic var redCircle = -1
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        orderId <- map["order_id"]
        createDate <- map["create_date"]
        statusId <- map["status_id"]
        selfCollect <- map["self_collect"]
        redCircle <- map["red_circle"]
    }
    
}

