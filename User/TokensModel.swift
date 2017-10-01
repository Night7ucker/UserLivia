//
//  TokensModel.swift
//  User
//
//  Created by BAMFAdmin on 25.09.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import RealmSwift
import ObjectMapper_Realm

class TokensModel: Object, Mappable{
    
    dynamic var accessToken: String?
    dynamic var refreshToken: String?
    dynamic var userStatus: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        accessToken <- map["access_token"]
        refreshToken <- map["refresh_token"]
        userStatus <- map["user_status"]
    }
    
    static func writeIntoRealm(response: DataResponse<TokensModel>){
        let result = response.result.value!
        let realm = try! Realm()
        if RealmDataManager.getTokensFromRealm().count != 0 {
            try! realm.write {
                realm.delete(RealmDataManager.getTokensFromRealm())
            }
        }
        try! realm.write {
            realm.add(result)
        }
    }
    
}
