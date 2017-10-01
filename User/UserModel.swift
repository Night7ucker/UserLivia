//
//  UserModelModel.swift
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

class UserModel: Object, Mappable{
    dynamic var id: String?
    dynamic var avatar: String?
    dynamic var email: String?
    dynamic var countryCode: String?
    dynamic var countryName: String?
    dynamic var countryId: String?
    dynamic var cityId: String?
    dynamic var cityName: String?
    dynamic var phoneNumber: String?
    dynamic var namePrefix: String?
    dynamic var firstName: String?
    dynamic var lastName: String?
    dynamic var age: String?	
    dynamic var sex: String?
    dynamic var online: String?
    dynamic var phoneCode: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        avatar <- map["avatar"]
        email <- map["email"]
        namePrefix <- map["name_prefix"]
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        age <- map["age"]
        sex <- map["sex"]
        phoneCode <- map["phone_code"]
        phoneNumber <- map["phone_number"]
        countryCode <- map["country_code"]
        countryId <- map["country_id"]
        countryName <- map["country_name"]
        cityName <- map["city_name"]
        cityId <- map["city_id"]

    }
    
    static func writeIntoRealm(response: DataResponse<UserModel>){
        let result = response.result.value!
        let realm = try! Realm()
        if RealmDataManager.getUserDataFromRealm().count > 0 {
            try! realm.write {
                realm.delete(RealmDataManager.getUserDataFromRealm())
            }
        }
        try! realm.write {
            realm.add(result)
        }
    }
    
    static func writePhoneIntoRealm(codeIndex: Int) {
        let realm = try! Realm()
        if RealmDataManager.getUserDataFromRealm().count > 0 {
            try! realm.write {
                realm.delete(RealmDataManager.getUserDataFromRealm())
            }
        }
        let userModelObject = UserModel()
        userModelObject.phoneCode = RealmDataManager.getDataFromCountries()[codeIndex].phoneCode!
        userModelObject.phoneNumber = RealmDataManager.getPhoneNumberFromRealm()[0].phoneNumber!
        RealmDataManager.writeIntoRealm(object: userModelObject)
    }

}
