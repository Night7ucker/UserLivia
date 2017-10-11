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
    @objc dynamic var id: String?
    @objc dynamic var avatar: String?
    @objc dynamic var email: String?
    @objc dynamic var countryCode: String?
    @objc dynamic var countryName: String?
    @objc dynamic var countryId: String?
    @objc dynamic var cityId: String?
    @objc dynamic var cityName: String?
    @objc dynamic var phoneNumber: String?
    @objc dynamic var namePrefix: String?
    @objc dynamic var firstName: String?
    @objc dynamic var lastName: String?
    @objc dynamic var age: String?
    @objc dynamic var sex: String?
    @objc dynamic var online: String?
    @objc dynamic var phoneCode: String?
    
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
