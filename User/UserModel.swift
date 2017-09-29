//
//  UserModelModel.swift
//  User
//
//  Created by User on 9/27/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import RealmSwift

class UserModel: Object {
    dynamic var id: String?
    dynamic var avatar: String?
    dynamic var email: String?
    dynamic var countryCode: String?
    dynamic var countryName: String?
    dynamic var countryId: String?
    dynamic var cityId: String?
    dynamic var cityName: String?
    dynamic var phoneNumber: String?
    dynamic var namePrefix: String?
    dynamic var firstName: String?
    dynamic var lastName: String?
    dynamic var age: String?	
    dynamic var sex: String?
    dynamic var online: String?
    dynamic var phoneCode: String?
}
