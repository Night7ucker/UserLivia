//
//  FindDoctorSpecialityModel.swift
//  User
//
//  Created by User on 10/9/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import RealmSwift
import ObjectMapper_Realm

class MappedFindDoctorSpecialityModel: Mappable {
    var doctorsSpecialityArray: [DoctorSpecialityModel]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        doctorsSpecialityArray <- map["body"]
    }
    
    static func writeIntoRealm(response: DataResponse<MappedFindDoctorSpecialityModel>){
        let result = response.result.value
        let realm = try! Realm()
        if let array = result?.doctorsSpecialityArray {
            for element in array {
                try! realm.write {
                    realm.add(element)
                }
            }
        }
    }
}

class DoctorSpecialityModel: Object, Mappable {
    @objc dynamic var id: String?
    @objc dynamic var name: String?
    @objc dynamic var color: String?
    @objc dynamic var image: String?
    @objc dynamic var children: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        color <- map["color"]
        image <- map["image"]
        children <- map["children"]
    }
    
}
