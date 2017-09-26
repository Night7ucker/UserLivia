//
//  GetAuthCodeRequest.swift
//  User
//
//  Created by BAMFAdmin on 24.09.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import Alamofire


class GetAuthCode{
    
    
    var phoneNumber: String?
    var phoneCode: String?
    
    init(number: String,code: String) {
        self.phoneCode = code
        self.phoneNumber = number

    }
    
    let id = UIDevice.current.identifierForVendor!.uuidString//"2125d2a0-5c85-3aa8-92d8-27944101880c"
    
    let url = "https://test.liviaapp.com/api/auth"
    
    
    
    
    
    func getAutCodeRequest() {
        let parameters: Parameters = [
            "phone_id": id,
            "phone_code": phoneCode!,
            "phone_number": phoneNumber!,
            "user_role": "4"
        ]
        let headers = [
            "Content-Type": "application/json",
            "LiviaApp-language": "en"
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            print(response.result.value!)
        }
    }
    
    
}
