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
    static let realm = try! Realm()
    static func writeIntoRealm(object: Object) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(object)
        }
    }
    
    static func getDataFromCountries() -> Results<CountryCodesModel> {
        let data = realm.objects(CountryCodesModel.self)
        return data
    }
    static func getPhoneNumberFromRealm() -> Results<PhoneNumberModel> {
        let data = realm.objects(PhoneNumberModel.self)
        return data
    }
    static func getTokensFromRealm() -> Results<TokensModel> {
        let data = realm.objects(TokensModel.self)
        return data
    }

    static func getRemindersFromRealm() -> Results<ReminderModel> {
        let data = realm.objects(ReminderModel.self)
        return data
    }
    static func getImageUrlFromRealm() -> Results<UploadImageModel> {
        let data = realm.objects(UploadImageModel.self)
        return data
    }
    static func getUserDataFromRealm() -> Results<UserModel> {
        let data = realm.objects(UserModel.self)
        return data
    }
    static func getCitiesNamesFromRealm() -> Results<City> {
        let data = realm.objects(City.self)
        return data
    }
    static func getDrugsFromRealm() -> Results<GetDrugsModel> {
        let data = realm.objects(GetDrugsModel.self)
        return data
    }
    static func getDrugsDescriptionFromRealm() -> Results<DrugsDescriptionModel> {
        let data = realm.objects(DrugsDescriptionModel.self)
        return data
    }
    static func getAddedDrugsDataFromRealm() -> Results<AddedToCartDrugsModel> {
        let data = realm.objects(AddedToCartDrugsModel.self)
        return data
    }
}
