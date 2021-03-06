//
//  PaymentModel.swift
//  User
//
//  Created by BAMFAdmin on 06.10.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import RealmSwift
import ObjectMapper_Realm

class MappedPaymentList: Mappable {
    var paymentListArray: [PaymentListModel]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        paymentListArray <- map["body"]
    }
    
    static func writeIntoRealm(response: DataResponse<MappedPaymentList>){
        let result = response.result.value
        let realm = try! Realm()
        if let array = result?.paymentListArray {
            for element in array {
                try! realm.write {
                    realm.add(element)
                }
            }
        }
    }
}

class PaymentListModel: Object, Mappable {
    @objc dynamic var transactionId = -1
    @objc dynamic var orderId: String?
    @objc dynamic var fullAmount: String?
    @objc dynamic var statusId: String?
    @objc dynamic var payMethodId: String?
    @objc dynamic var payMethod: String?
    @objc dynamic var statusName: String?
    @objc dynamic var createDate: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        transactionId <- map["transaction_id"]
        orderId <- map["order_id"]
        fullAmount <- map["full_amount"]
        statusId <- map["status_id"]
        payMethodId <- map["pay_method_id"]
        payMethod <- map["pay_method"]
        statusName <- map["status_name"]
        createDate <- map["createDate"]
    }
    
}
