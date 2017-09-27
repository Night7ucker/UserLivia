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


class EditUserProfileRequest{
    
    func editUserFunc(completion: @escaping (Bool) -> Void)  {
        
        let url = "https://test.liviaapp.com/api/user"
        
        let parameters: Parameters = [
            "avatar": RealmDataManager.getUserDataFromRealm()[0].avatar!,
            "name_prefix": RealmDataManager.getUserDataFromRealm()[0].namePrefix!,
            "first_name": RealmDataManager.getUserDataFromRealm()[0].firstName!,
            "last_name": RealmDataManager.getUserDataFromRealm()[0].lastName!,
            "age": RealmDataManager.getUserDataFromRealm()[0].age!,
            "sex": RealmDataManager.getUserDataFromRealm()[0].sex!,
            "phone_code": RealmDataManager.getUserDataFromRealm()[0].countryCode!,
            "phone_number": RealmDataManager.getUserDataFromRealm()[0].phoneNumber!,
            "email": RealmDataManager.getUserDataFromRealm()[0].email!
            
            ]
        let headers = [
            "Content-Type": "application/json",
            "LiviaApp-language": "en",
            "LiviaApp-timezone": "180",
            "LiviaApp-APIVersion": "2.0",
            "LiviaApp-Token": RealmDataManager.getTokensFromRealm()[0].accessToken!
        ]
        
        Alamofire.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in

            completion(true)
        }
        
    }
}
