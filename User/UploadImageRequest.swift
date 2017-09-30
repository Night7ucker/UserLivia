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

        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in

            guard let result = response.result.value as? [String: AnyObject] else{ return }

            if let res = result["image"] {
                let realm = try! Realm()
                if RealmDataManager.getImageUrlFromRealm().count > 0 {
                    try! realm.write {
                        realm.delete(RealmDataManager.getImageUrlFromRealm())
                    }
                }
                let imageUrlObject = UploadImageModel()
                imageUrlObject.imageUrl = res as? String
                RealmDataManager.writeIntoRealm(object: imageUrlObject)
                print(response.result.value!)
            }
         
        }
    }
    
}
