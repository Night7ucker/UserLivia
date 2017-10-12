//
//  GetDoctorModel.swift
//  User
//
//  Created by User on 10/12/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import RealmSwift
import ObjectMapper_Realm

class MappedDoctorModel: Mappable {
    var doctorsArray: [DoctorModel]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        doctorsArray <- map["body"]
    }
    
    static func writeIntoRealm(response: DataResponse<MappedDoctorModel>){
        let result = response.result.value
        let realm = try! Realm()
        if let array = result?.doctorsArray {
            for element in array {
                try! realm.write {
                    realm.add(element)
                }
            }
        }
    }
}

class DoctorModel: Object, Mappable {
    @objc dynamic var id: String?
    @objc dynamic var name: String?
    @objc dynamic var consultationsFees: String?
    @objc dynamic var address: String?
    @objc dynamic var avatar: String?
    @objc dynamic var latitude: String?
    @objc dynamic var longitude: String?
    @objc dynamic var experienceYears: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        consultationsFees <- map["consultation_fees"]
        avatar <- map["avatar"]
        address <- map["address"]
        experienceYears <- map["experience_years"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }
    
}
