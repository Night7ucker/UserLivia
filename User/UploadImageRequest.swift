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


class UploadImageRequest{
    
        func uploadImage(imageString: String)  {

            let url = "https://test.liviaapp.com/api/image"
            let parameters: Parameters = [
                "image": imageString,
                "type": "users"
            ]

            let headers = [
                "Content-Type": "application/json",
                "LiviaApp-language": "en",
                "LiviaApp-APIVersion": "2.0",
                "LiviaApp-Token": RealmDataManager.getTokensFromRealm()[0].accessToken!
            ]

            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse
                <UploadImageModel>) in
                print(response.result.value!)
                UploadImageModel.writeIntoRealm(response: response)
            }

        }
    
    func uploadImage(imageString: String, completion: @escaping (Bool) -> Void)  {
        
        let url = "https://test.liviaapp.com/api/image"
        let parameters: Parameters = [
            "image": imageString,
            "type": "users"
        ]
        
        let headers = [
            "Content-Type": "application/json",
            "LiviaApp-language": "en",
            "LiviaApp-APIVersion": "2.0",
            "LiviaApp-Token": RealmDataManager.getTokensFromRealm()[0].accessToken!
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse
            <UploadImageModel>) in
            print(response.result.value!)
            UploadImageModel.writeIntoRealm(response: response)
//            if completion != nil {
//                completion!(true)
//            }
            completion(true)
        }
        
    }
    
}



