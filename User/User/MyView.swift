//
//  MyView.swift
//  User
//
//  Created by BAMFAdmin on 10.10.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class MyView: UIView {

    @IBOutlet var priceValue: UILabel!

    @IBOutlet var priceForAlternative: UILabel!
    @IBOutlet var priceForCancelOrder: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if RealmDataManager.getOrderDescriptionModel().count > 0 {
            switch RealmDataManager.getOrderDescriptionModel()[0].statusId! {
            case "3":
                priceValue.text = RealmDataManager.getOrderDescriptionModel()[0].totatPrice! + "BYN"
            case "6":
                priceForCancelOrder.text = RealmDataManager.getOrderDescriptionModel()[0].totatPrice! + "BYN"
            case "16":
                priceForAlternative.text = RealmDataManager.getOrderDescriptionModel()[0].totatPrice! + "BYN"
            default:
                return
            }
        }
    }
}
