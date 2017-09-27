//
//  CityNameRealmModel.swift
//  User
//
//  Created by User on 9/27/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import RealmSwift

class City: Object {
    dynamic var cityName: String?
    dynamic var countryName: String?
    
    static func formSectionsForCities() -> [String] {
        var arrayOfSections = [String]()
        
        let arrayOfCities = RealmDataManager.getCitiesNamesFromRealm()
        for city in arrayOfCities {
            if arrayOfSections.contains(city.countryName!) == false {
                arrayOfSections.append(city.countryName!)
            }
        }
        return arrayOfSections
    }
}
