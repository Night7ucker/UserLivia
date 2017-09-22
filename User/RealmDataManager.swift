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
        let days = realm.objects(CountryCodesModel.self)
        return days
    }
  /*
    static func getDaysInfoFromDataBaseWithArrayResults(realm: Realm) -> [RealmModel] {
        let days = Array(realm.objects(RealmModel.self))
        let cityName = DataManager.getCityNameFromDatabase(realm: realm)
        var outputArray = [RealmModel]()
        for day in days {
            if day.cityName == cityName {
                outputArray.append(day)
            }
        }
        return outputArray
    }
   */
    
}
