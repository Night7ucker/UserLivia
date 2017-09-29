//
//  UploadImageRequest.swift
//  User
//
//  Created by BAMFAdmin on 26.09.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift


class EditUserCityRequest{
    
    func editUserFunc(completion: @escaping (Bool) -> Void)  {
        
        let url = "https://test.liviaapp.com/api/city"
        
        let parameters: Parameters = [
            "city_id": RealmDataManager.getCitiesNamesFromRealm()[0].cityId!,
        ]
        let headers = [
            "Content-Type": "application/json",
            "LiviaApp-language": "en",
            "LiviaApp-timezone": "180",
            "LiviaApp-APIVersion": "2.0",
            "LiviaApp-country": RealmDataManager.getUserDataFromRealm()[0].countryName!,
            "LiviaApp-city": RealmDataManager.getUserDataFromRealm()[0].cityId!,
            "LiviaApp-Token": RealmDataManager.getTokensFromRealm()[0].accessToken!
        ]
        
        Alamofire.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            print(response.result.value!)
            completion(true)
        }
        
    }
}
