//
//  UploadImageModel.swift
//  User
//
//  Created by BAMFAdmin on 26.09.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import RealmSwift
import ObjectMapper_Realm

class UploadImageModel: Object, Mappable {
    
    dynamic var imageUrl: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        imageUrl <- map["image"]
    }
    
    static func writeIntoRealm(response: DataResponse<UploadImageModel>){
        let result = response.result.value!
        let realm = try! Realm()
        if RealmDataManager.getImageUrlFromRealm().count > 0 {
            try! realm.write {
                realm.delete(RealmDataManager.getImageUrlFromRealm())
            }
        }
        try! realm.write {
            realm.add(result)
        }
    }

}

