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
    @objc dynamic var id: String?
    @objc dynamic var type = -1
    @objc dynamic var brandName: String?
    @objc dynamic var amount = 0
    @objc dynamic var quantityMeasuring: String?

    override static func primaryKey() -> String? {
        return "id"
    }
}
