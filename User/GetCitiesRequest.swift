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
import AlamofireObjectMapper
import ObjectMapper_Realm

class GetCitiesRequest {
    
    static func getCities(offsetForCities: Int, completion: @escaping (Bool) -> Void) {
        let headers = [
            "LiviaApp-language": "en",
            "LiviaApp-timezone": "180",
            "LiviaApp-APIVersion": "2.0"
        ]
        
        let url = "https://test.liviaapp.com/api/city?active=1&offset=\(offsetForCities)&limit=20&search="

        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse
            <MappedCityModel>) in
            MappedCityModel.writeIntoRealm(response: response)

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
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse
            <MappedCityModel>) in
            MappedCityModel.writeIntoRealm(response: response)

            completion(true)
        }
    }
}


