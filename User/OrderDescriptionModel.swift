//
//  OrderDescriptionModel.swift
//  User
//
//  Created by BAMFAdmin on 04.10.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import RealmSwift
import ObjectMapper_Realm


class OrderDescriptionModelImage: Object{
    dynamic var imageUrl: String?
    dynamic var selfCollect: String?

    
}

class OrderDescriptionModel: Object {
    dynamic var drugName: String?
    dynamic var quantity: String?
    dynamic var quantityMeasuring: String?
    
}
