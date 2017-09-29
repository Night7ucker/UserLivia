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


class GetUserProfileRequest{
    
    func GetUserProfileFunc(completion: @escaping (Bool) -> Void)  {
        
        let url = "https://test.liviaapp.com/api/user"
        
        let headers = [
            "Content-Type": "application/json",
            "LiviaApp-language": "en",
            "LiviaApp-timezone": "180",
            "LiviaApp-APIVersion": "2.0",
            "LiviaApp-Token": RealmDataManager.getTokensFromRealm()[0].accessToken!
        ]
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            print(response.result.value!)
            let realm = try! Realm()
            if RealmDataManager.getUserDataFromRealm().count > 0 {
                try! realm.write {
                    realm.delete(RealmDataManager.getUserDataFromRealm())
                }
            }
            
            guard let result = response.result.value as? [String: AnyObject] else{ return }

            let userModelObject = UserModel()
            userModelObject.id = result["id"] as? String
            userModelObject.avatar = result["avatar"] as? String
            userModelObject.email = result["email"] as? String
            userModelObject.namePrefix = result["name_prefix"] as? String
            userModelObject.firstName = result["first_name"] as? String
            userModelObject.lastName = result["last_name"] as? String
            userModelObject.age = result["age"] as? String
            userModelObject.sex = result["sex"] as? String
            userModelObject.online = result["online"] as? String
            userModelObject.phoneCode = result["phone_code"] as? String
            userModelObject.phoneNumber = result["phone_number"] as? String
            userModelObject.countryCode = result["country_code"] as? String
            userModelObject.countryId = result["country_id"] as? String
            userModelObject.countryName = result["country_name"] as? String
            userModelObject.cityName = result["city_name"] as? String
            userModelObject.cityId = result["city_id"] as? String
            RealmDataManager.writeIntoRealm(object: userModelObject, realm: realm)
            completion(true)
        }
        
    }
}


