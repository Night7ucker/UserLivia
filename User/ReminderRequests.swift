//
//  ReminderRequests.swift
//  User
//
//  Created by User on 9/28/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class ReminderRequests {
    
//    static func addReminder() {
//        let headers = [
//            
//        ]
//        
//        let url = "https://admin.liviaapp.com/api/reminder"
//        
//    }
    
    static func getCities(offsetForCities: Int, completion: @escaping (Bool) -> Void) {
        let headers = [
            "LiviaApp-language": "en",
            "LiviaApp-timezone": "180",
            "LiviaApp-APIVersion": "2.0"
        ]
        
        let url = "https://test.liviaapp.com/api/city?active=1&offset=\(offsetForCities)&limit=20&search="
        
        
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            guard let result = response.result.value as? [String : AnyObject] else{ return }
            guard let body = result["body"] as? [[String : AnyObject]] else { return }
            
            for element in body {
                let country = element["country"] as? String
                let city = element["name"] as? String
                
                let cityObject = City()
                
                cityObject.cityName = city
                cityObject.countryName = country
                
                let realm = try! Realm()
                RealmDataManager.writeIntoRealm(object: cityObject, realm: realm)
                
            }
            completion(true)
        }
    }
    
    static func getCitiesForSearchRequest(searchStringForCities: String, completion: @escaping (Bool) -> Void) {
        let headers = [
            "LiviaApp-language": "en",
            "LiviaApp-timezone": "180",
            "LiviaApp-APIVersion": "2.0"
        ]
        
        let url = "https://test.liviaapp.com/api/city?active=1&offset=0&limit=20&search=\(searchStringForCities)"
        
        let realm = try! Realm()
        if RealmDataManager.getCitiesNamesFromRealm().count != 0 {
            try! realm.write {
                realm.delete(RealmDataManager.getCitiesNamesFromRealm())
            }
        }
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            
            
            guard let result = response.result.value as? [String : AnyObject] else{ return }
            print(result)
            guard let body = result["body"] as? [[String : AnyObject]] else { return }
            
            for element in body {
                let country = element["country"] as? String
                let city = element["name"] as? String
                
                let cityObject = City()
                
                cityObject.cityName = city
                cityObject.countryName = country
                
                let realm = try! Realm()
                RealmDataManager.writeIntoRealm(object: cityObject, realm: realm)
                
            }
            completion(true)
        }
    }
}


