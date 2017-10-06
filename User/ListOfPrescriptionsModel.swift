//
//  ListOfPrescriptionsModel.swift
//  User
//
//  Created by User on 10/5/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import RealmSwift
import ObjectMapper_Realm

class MappedPrescriptionListModel: Mappable {
    var prescriptionListModelArray: [PrescriptionModel]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        prescriptionListModelArray <- map["body"]
    }
    
    static func writeIntoRealm(response: DataResponse<MappedPrescriptionListModel>){
        let result = response.result.value
        let realm = try! Realm()
        if let array = result?.prescriptionListModelArray {
            for element in array {
                try! realm.write {
                    realm.add(element)
                }
            }
        }
    }
}

class PrescriptionModel: Object, Mappable {
    dynamic var id: String?
    dynamic var orderID: String?
    dynamic var image: String?
    dynamic var createDate: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        orderID <- map["order_id"]
        image <- map["image"]
        createDate <- map["create_date"]
    }
    
}
