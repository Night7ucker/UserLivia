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
import AlamofireObjectMapper


class RegistrationUserRequest{
    
    func registerUserFunc(prefixName: String, fName: String, lName: String, age: String, sex: String, mail: String, imageUrl: String, codeIndex: Int, completion: @escaping (Bool) -> Void)  {
        
            let url = "https://test.liviaapp.com/api/auth"
            let parameters: Parameters = [
                "user_role": "4",
                "country_code": "by",
                "avatar": imageUrl,
                "name_prefix": prefixName,
                "first_name": fName,
                "last_name": lName,
                "age": age,
                "sex": sex,
                "phone_code": RealmDataManager.getDataFromCountries()[codeIndex].phoneCode!,
                "phone_number": RealmDataManager.getPhoneNumberFromRealm()[0].phoneNumber!,
                "email": mail,
                
                ]
            let headers = [
                "Content-Type": "application/json",
                "LiviaApp-language": "en",
                "LiviaApp-timezone": "180",
                "LiviaApp-APIVersion": "2.0",
                "LiviaApp-Token": RealmDataManager.getTokensFromRealm()[0].accessToken!
            ]
            
        Alamofire.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse
            <UserModel>) in
            print(response)
            UserModel.writeIntoRealm(response: response)
            UserModel.writePhoneIntoRealm(codeIndex: codeIndex)
            completion(true)
        }
    }
    
}




