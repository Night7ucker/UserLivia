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
    
    dynamic var deliveryCost: String?
    dynamic var orderId: String?
    dynamic var selfCollect: String?
    dynamic var totatPrice: String?
    dynamic var totalDrugsPrice: String?
    dynamic var statusId: String?

}

class OrderDrugsDescriptionModel: Object {
    dynamic var drugName: String?
    dynamic var drugId: String?
    dynamic var pAdmin: String?
    dynamic var pLat: String?
    dynamic var pLong: String?
    dynamic var pId: String?
    dynamic var pNumber: String?
    dynamic var quantity: String?
    dynamic var quantityMeasuring: String?
    dynamic var drugPrice = 0
    dynamic var activeItem: String?
}
