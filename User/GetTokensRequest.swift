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
import AlamofireObjectMapper

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
        let id = UIDevice.current.identifierForVendor!.uuidString
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

        Alamofire.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse
            <TokensModel>) in
            TokensModel.writeIntoRealm(response: response)
            if (response.result.value?.accessToken != nil) {
                completion(true)
            } else {
                completion(false)
            }
        }
    } 
}





