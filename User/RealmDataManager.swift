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
    static func getPhoneNumberFromRealm() -> Results<PhoneNumberModel> {
        let realm = try! Realm()
        let data = realm.objects(PhoneNumberModel.self)
        return data
    }
    static func getTokensFromRealm() -> Results<TokensModel> {
        let realm = try! Realm()
        let data = realm.objects(TokensModel.self)
        return data
    }

    static func getRemindersFromRealm() -> Results<ReminderModel> {
        let realm = try! Realm()
        let data = realm.objects(ReminderModel.self)
        return data
    }
    static func getImageUrlFromRealm() -> Results<UploadImageModel> {
        let realm = try! Realm()
        let data = realm.objects(UploadImageModel.self)
        return data
    }
    
}
