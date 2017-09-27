//
//  GetCitiesRequest.swift
//  User
//
//  Created by User on 9/27/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class GetCitiesRequest {
    
    static func getCities(completion: @escaping (Bool) -> Void) {
        let headers = [
            "LiviaApp-language": "en",
            "LiviaApp-timezone": "180",
            "LiviaApp-APIVersion": "2.0"
        ]
        
        let url = "https://test.liviaapp.com/api/city?active=1&offset=0&limit=40&search="
        
        
        
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
            
//            guard let listOfCities = body["list_of_countries"] as? [[String: AnyObject]] else{ return }
            
//            for element in listOfCities {
////                realmObject.countryFlag = element["flag"] as? String
////                realmObject.countryName = element["name"] as? String
////                realmObject.phoneCode = element["phone_country_code"] as? String
//
//                let country = element["country"] as? String
//                let city = element["name"] as? String
//                let countryID = element["id"] as? String
//                
//                print(country)
//                print(city)
//                print(countryID)
//
//            }
            //            print(body)
            //            print(body.first)
            //                let country = element["country"] as? String
            //                let city = element["name"] as? String
            //                let countryID = element["id"] as? String
            //
            //                print(country)
            //                print(city)
            //                print(countryID)
            
            
            
        }
    }
}


