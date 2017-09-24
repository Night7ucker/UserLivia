//
//  RealmDataManager.swift
//  User
//
//  Created by BAMFAdmin on 22.09.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDataManager {
    
    static func writeIntoRealm(object: Object, realm: Realm) {
        try! realm.write {
            realm.add(object)
        }
    }
    
    static func getDataFromCountries() -> Results<CountryCodesModel> {
        let realm = try! Realm()
        let data = realm.objects(CountryCodesModel.self)
        return data
    }
    
    
    static func getPersonTitleFromRealm() -> Results<PersonTitleModel> {
        let realm = try! Realm()
        let data = realm.objects(PersonTitleModel.self)
        return data
    }
    static func getIndexCountryFromRealm() -> Results<CountryCodesIndexModel> {
        let realm = try! Realm()
        let data = realm.objects(CountryCodesIndexModel.self)
        return data
    }
    static func getPhoneNumberFromRealm() -> Results<PhoneNumberModel> {
        let realm = try! Realm()
        let data = realm.objects(PhoneNumberModel.self)
        return data
    }


    
}
