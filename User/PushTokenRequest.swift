//
//  PushTokenRequest.swift
//  User
//
//  Created by BAMFAdmin on 12.10.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift


class PushTokenRequest {
    
    func getPushTokenRequest() {
        
        let url = "https://test.liviaapp.com/api/auth/1"
        let parameters: Parameters = [
            "push_token": RealmDataManager.getPushTokenFromRealm()[0].pushToken!
        ]
        let headers = [
            "Content-Type": "application/json",
            "LiviaApp-language": "en",
            "LiviaApp-country": RealmDataManager.getUserDataFromRealm()[0].countryCode!,
            "LiviaApp-city": RealmDataManager.getUserDataFromRealm()[0].cityId!,
            "LiviaApp-timezone": "180",
            "LiviaApp-APIVersion": "2.0",
            "LiviaApp-Token": RealmDataManager.getTokensFromRealm()[0].accessToken!
        ]
        
        print(parameters)
        print(headers)
        Alamofire.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            print(response)
        })
    }
}


