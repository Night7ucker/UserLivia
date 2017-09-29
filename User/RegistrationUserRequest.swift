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
            
            Alamofire.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
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
                userModelObject.phoneCode = RealmDataManager.getDataFromCountries()[codeIndex].phoneCode!
                userModelObject.phoneNumber = RealmDataManager.getPhoneNumberFromRealm()[0].phoneNumber!
                RealmDataManager.writeIntoRealm(object: userModelObject, realm: realm)
                completion(true)
            }

        }
}
