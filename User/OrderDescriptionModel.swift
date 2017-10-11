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
   @objc dynamic var imageUrl: String?
}

class OrderDescriptionModel: Object {
    
    @objc dynamic var deliveryCost: String?
    @objc dynamic var orderId: String?
    @objc dynamic var selfCollect: String?
    @objc dynamic var totatPrice: String?
    @objc dynamic var totalDrugsPrice: String?
    @objc dynamic var statusId: String?
    @objc dynamic var createDate: String?

}

class OrderDrugsDescriptionModel: Object {
    @objc dynamic var drugName: String?
    @objc dynamic var drugId: String?
    @objc dynamic var pAdmin: String?
    @objc dynamic var pLat: String?
    @objc dynamic var pLong: String?
    @objc dynamic var pId: String?
    @objc dynamic var pNumber: String?
    @objc dynamic var quantity: String?
    @objc dynamic var quantityMeasuring: String?
    @objc dynamic var drugPrice: Double = 0
    @objc dynamic var activeItem: String?
    @objc dynamic var pName: String?
}
