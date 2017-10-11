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
    
    @IBOutlet weak var bestPriceOfferLabelOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if RealmDataManager.getOrderDescriptionModel().count > 0 {
            switch RealmDataManager.getOrderDescriptionModel()[0].statusId! {
            case "3":
                UIView.animate(withDuration: 0.9, delay: 0, options: [.repeat,.autoreverse], animations: {
                    self.bestPriceOfferLabelOutlet.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                }, completion: { _ in
                    UIView.animate(withDuration: 0.9, animations: {
                        self.bestPriceOfferLabelOutlet.transform = .identity
                    })
                })
            default:
                break
            }
        }
        
        
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
