//
//  GetDrugsModel.swift
//  User
//
//  Created by BAMFAdmin on 29.09.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import RealmSwift
import ObjectMapper_Realm


class DrugsDescriptionModel: Object, Mappable{
    dynamic var id: String?
    dynamic var type = -1
    dynamic var brandName: String?
    dynamic var contraindications: String?
    dynamic var desc: String?
    dynamic var dosage: String?
    dynamic var dosageUnits: String?
    dynamic var manufacturerCompany: String?
    dynamic var name: String?
    dynamic var sideEffects: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        brandName <- map["brand_name"]
        contraindications <- map["contraindications"]
        desc <- map["description"]
        dosage <- map["dosage"]
        dosageUnits <- map["dosage_units"]
        manufacturerCompany <- map["manufacturer_company"]
        name <- map["name"]
        sideEffects <- map["side_effects"]
    }
    
    static func writeIntoRealm(response: DataResponse<DrugsDescriptionModel>){
        let result = response.result.value!
        let realm = try! Realm()
        if RealmDataManager.getDrugsDescriptionFromRealm().count > 0 {
            try! realm.write {
                realm.delete(RealmDataManager.getDrugsDescriptionFromRealm())
            }
        }
        try! realm.write {
            realm.add(result)
        }
    }


    
}
