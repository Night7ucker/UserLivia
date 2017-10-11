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
    @objc dynamic var id: String?
    @objc dynamic var type = -1
    @objc dynamic var brandName: String?
    @objc dynamic var contraindications: String?
    @objc dynamic var desc: String?
    @objc dynamic var dosage: String?
    @objc dynamic var dosageUnits: String?
    @objc dynamic var manufacturerCompany: String?
    @objc dynamic var name: String?
    @objc dynamic var sideEffects: String?
    @objc dynamic var quantityMeasuring: String?
    @objc dynamic var amount = 1
    
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
        quantityMeasuring <- map["quantity_measuring"]
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
