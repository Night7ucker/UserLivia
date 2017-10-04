//
//  GetPharmaciesRequest.swift
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




class MappedPharmacyModel: Mappable {
    var PharmacyModelArray: [Pharmacy]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        PharmacyModelArray <- map["body"]
    }
    
    static func writeIntoRealm(response: DataResponse<MappedPharmacyModel>){
        let result = response.result.value
        print(result)
        let realm = try! Realm()
        if let array = result?.PharmacyModelArray {
            for element in array {
                try! realm.write {
                    realm.add(element)
                }
            }
        }
    }
}

class Pharmacy: Object, Mappable {
    dynamic var userId: String?
    dynamic var latitude: String?
    dynamic var longtitude: String?
    dynamic var avatar: String?
    dynamic var adminName: String?
    dynamic var pharmacyName: String?
    dynamic var physicalAddress: String?
    dynamic var workTime: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        userId <- map["user_id"]
        latitude <- map["latitude"]
        longtitude <- map["longitude"]
        avatar <- map["avatar"]
        adminName <- map["admin_name"]
        pharmacyName <- map["pharmacy_name"]
        physicalAddress <- map["physical_address"]
        workTime <- map["work_time"]
    }
    
}

