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
            
            guard let result = response.result.value as? [String: AnyObject] else{ return }
            UserProfile.avatar = result["avatar"] as? String
            UserProfile.namePrefix = result["name_prefix"] as? String
            UserProfile.firstName = result["first_name"] as? String
            UserProfile.lastName = result["last_name"] as? String

            completion(true)
        }
        
    }
}

class UserProfile {
    static var avatar: String?
    static var namePrefix: String?
    static var firstName: String?
    static var lastName: String?
}

