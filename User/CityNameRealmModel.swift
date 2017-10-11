//
//  CityNameRealmModel.swift
//  User
//
//  Created by User on 9/27/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import RealmSwift
import ObjectMapper_Realm




class MappedCityModel: Mappable {
    var CityModelArray: [City]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        CityModelArray <- map["body"]
    }
    
    static func writeIntoRealm(response: DataResponse<MappedCityModel>){
        let result = response.result.value
        let realm = try! Realm()
        if let array = result?.CityModelArray {
            for element in array {
                try! realm.write {
                    realm.add(element)
                }
            }
        }
    }
}

class City: Object, Mappable {
        @objc dynamic var cityName: String?
        @objc dynamic var countryName: String?
        @objc dynamic var countryId: String?
        @objc dynamic var cityId: String?
        @objc dynamic var countryCode: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        cityName <- map["name"]
        countryName <- map["country"]
        countryId <- map["country_id"]
        cityId <- map["id"]
        countryCode <- map["country_code"]
    }
    
}

