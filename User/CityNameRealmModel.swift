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
        dynamic var cityName: String?
        dynamic var countryName: String?
        dynamic var countryId: String?
        dynamic var cityId: String?
        dynamic var countryCode: String?
    
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

