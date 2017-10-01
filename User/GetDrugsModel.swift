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


class GetDrugsModel: Object, Mappable {
    dynamic var id: String?
    dynamic var name: String?
    dynamic var type = -1
    
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        type <- map["type"]
    }
  
}

class MappedGetDrugsModel: Mappable {
    var GetDrugsModelArray: [GetDrugsModel]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        GetDrugsModelArray <- map["body"]
    }
    
    static func writeIntoRealm(response: DataResponse<MappedGetDrugsModel>){
        let result = response.result.value
        let realm = try! Realm()
        if RealmDataManager.getDrugsFromRealm().count > 0 {
            try! realm.write {
                realm.delete(RealmDataManager.getDrugsFromRealm())
            }
        }
        if let array = result?.GetDrugsModelArray {
            for element in array {
                try! realm.write {
                    realm.add(element)
                }
            }
        }
    }
}

