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
    
    @IBOutlet weak var deliveryTruckImageViewOutlet: UIImageView!
    
    @IBOutlet weak var forestBackgrounImageViewOutlet: UIImageView!
    
    
    
    var circleView = UIView()
    var checkLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if RealmDataManager.getOrderDescriptionModel().count > 0 {
            switch RealmDataManager.getOrderDescriptionModel()[0].statusId! {
            case "3":
                UIView.animate(withDuration: 0.9, delay: 0, options: [.repeat, .autoreverse], animations: {
                    self.bestPriceOfferLabelOutlet.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                }, completion: { _ in
                    UIView.animate(withDuration: 0.9, animations: {
                        self.bestPriceOfferLabelOutlet.transform = .identity
                    })
                })
            case "7":
                circleView.frame = CGRect(x: 10, y: 10, width: 40, height: 40)
                circleView.center = center
                circleView.layer.cornerRadius = circleView.frame.size.width / 2
                circleView.clipsToBounds = true
                
                circleView.backgroundColor = .clear
                circleView.layer.borderWidth = 1.5
                circleView.layer.borderColor = UIColor.white.cgColor
                circleView.isHidden = true
                
                addSubview(circleView)
                
                checkLabel.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                checkLabel.textColor = .white
                checkLabel.font = UIFont.systemFont(ofSize: 35)
                checkLabel.textAlignment = .center
                checkLabel.text = "✓"
                checkLabel.center = center
                checkLabel.isHidden = true
                checkLabel.alpha = 0
                
                addSubview(checkLabel)
                
                animateDone(circleView: circleView, checkLabel: checkLabel)
//                animateInfinitelyWithDelay(delay: 0.2, duration: 1)
            case "4":
                deliveryTruckImageViewOutlet.layer.zPosition = 1
                animateBackgroundMoving(forestBackgrounImageViewOutlet)
                animateCarRotation(deliveryTruckImageViewOutlet)
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
    
    func animateBackgroundMoving(_ image: UIImageView) {
        UIView.animate(withDuration: 5, delay: 0, options: [.curveLinear, .autoreverse], animations: {
            image.transform = CGAffineTransform(translationX: -100, y: 0)
        }) { (success: Bool) in
            image.transform = CGAffineTransform.identity
            self.animateBackgroundMoving(image)
        }
    }
    
    func animateCarRotation(_ image: UIImageView) {
        UIView.animate(withDuration: 0.25, delay: 3, options: [.autoreverse, .curveEaseIn], animations: {
            image.transform = CGAffineTransform(rotationAngle: 0.1)
        }, completion: { _ in
            image.transform = .identity
            self.animateCarRotation(image)
        })
    }
    
    @objc func animateDone(circleView: UIView, checkLabel: UILabel) {
        circleView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        UIView.animate(withDuration: 1, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.repeat], animations: {
            circleView.isHidden = false
            circleView.transform = .identity
            checkLabel.frame.origin.y += 20
            UIView.animate(withDuration: 0.7, delay: 0.2, options: [.repeat], animations: {
                checkLabel.isHidden = false
                checkLabel.alpha = 1
                checkLabel.frame.origin.y -= 20
            }, completion: nil)
        }, completion: nil)
    }
    
//    func animateInfinitelyWithDelay(delay : TimeInterval, duration : TimeInterval) {
//
//        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],
//                                   animations: {
//                                    self.circleView.isHidden = false
//                                    self.circleView.transform = .identity
//                                    self.checkLabel.frame.origin.y += 20
//                                    UIView.animate(withDuration: 0.7, delay: 0.2, options: [], animations: {
//                                        self.checkLabel.isHidden = false
//                                        self.checkLabel.alpha = 1
//                                        self.checkLabel.frame.origin.y -= 20
//                                    }, completion: nil)
//        }) { (finished) -> Void in
//            if finished {
//                self.animateInfinitelyWithDelay(delay: delay, duration: duration)
//            }
//        }
//
//    }
}
