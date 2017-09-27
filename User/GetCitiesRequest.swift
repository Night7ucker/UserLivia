//
//  GetCitiesRequest.swift
//  User
//
//  Created by User on 9/27/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import Alamofire

class GetCitiesRequest {
    
    static func getCities(completion: @escaping(Bool, [City]) -> Void) {
        let headers = [
            "LiviaApp-language": "en",
            "LiviaApp-timezone": "180",
            "LiviaApp-APIVersion": "2.0"
        ]
        
        let url = "https://test.liviaapp.com/api/city?active=1&offset=0&limit=20&search="
        
        
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            var citiesArray = [City]()
            
            guard let result = response.result.value as? [String : AnyObject] else{ return }
            guard let body = result["body"] as? [[String : AnyObject]] else { return }
            
            for element in body {
                let country = element["country"] as? String
                let city = element["name"] as? String
                
                let cityObject = City()
                
                cityObject.cityName = city
                cityObject.countryName = country
                
                citiesArray.append(cityObject)

            }
            
            completion(true, citiesArray)
            
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

class City {
    var cityName: String?
    var countryName: String?
    
    static func formSectionsForCities(citiesArray: [City]) -> [String] {
        var arrayOfSections = [String]()
        for city in citiesArray {
            if arrayOfSections.contains(city.countryName!) == false {
                arrayOfSections.append(city.countryName!)
            }
        }
        return arrayOfSections
    }
}
