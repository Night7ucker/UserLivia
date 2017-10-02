//
//  AddedToCartDrugsModel.swift
//  User
//
//  Created by BAMFAdmin on 02.10.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import RealmSwift

class AddedToCartDrugsModel: Object{
    dynamic var id: String?
    dynamic var type = -1
    dynamic var brandName: String?
    dynamic var amount = 0
    dynamic var quantityMeasuring: String?

    override static func primaryKey() -> String? {
        return "id"
    }
}
