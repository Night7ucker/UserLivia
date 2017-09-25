//
//  GetTokensRequest.swift
//  User
//
//  Created by BAMFAdmin on 25.09.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class GetTokensRequest{
    
    var phoneNumber: String?
    var phoneCode: String?
    var authCode: String?

    
    init(phoneNumber: String,phoneCode: String, authCode: String) {
        self.phoneCode = phoneCode
        self.phoneNumber = phoneNumber
        self.authCode = authCode
        
    }
    
    func confirmAuthCode(completion: @escaping (Bool) -> Void) {
        let id = UIDevice.current.identifierForVendor!.uuidString //"2125d2a0-5c85-3aa8-92d8-27944101880c"
        let url = "https://test.liviaapp.com/api/auth"
        let parameters: Parameters = [
            "phone_id": id,
            "phone_code": phoneCode!,
            "phone_number": phoneNumber!,
            "auth_code": authCode!,
            "os_type": "2",
            "user_role": "4"
        ]
        let headers = [
            "Content-Type": "application/json",
            "LiviaApp-language": "en",
            "LiviaApp-APIVersion": "2.0"
        ]

        Alamofire.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            guard let result = response.result.value as? [String: AnyObject] else{ return }
            if let _ = result["code"] {
                completion(false)
            } else {
                let realm = try! Realm()
                let realmTokensObject = TokensModel()
                if RealmDataManager.getTokensFromRealm().count != 0 {
                    try! realm.write {
                        realm.delete(RealmDataManager.getTokensFromRealm())
                    }
                }
                realmTokensObject.userStatus = result["user_status"] as? String
                realmTokensObject.accessToken = result["access_token"] as? String
                realmTokensObject.refreshToken = result["refresh_token"] as? String
                RealmDataManager.writeIntoRealm(object: realmTokensObject, realm: realm)
                completion(true)
            }
        }
    }
 
}







