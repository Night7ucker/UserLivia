//
//  RegisterCountryModel.swift
//  User
//
//  Created by BAMFAdmin on 22.09.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import RealmSwift


class CountryCodesModel: Object{
    dynamic var countryName: String?
    dynamic var phoneCode: String?
    dynamic var countryFlag: String?
    
}
