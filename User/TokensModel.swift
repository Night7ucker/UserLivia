//
//  TokensModel.swift
//  User
//
//  Created by BAMFAdmin on 25.09.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import RealmSwift

class TokensModel: Object{
    dynamic var accessToken: String?
    dynamic var refreshToken: String?
    dynamic var userStatus: String?
}
