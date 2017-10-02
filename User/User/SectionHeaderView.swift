//
//  SectionHeaderView.swift
//  User
//
//  Created by User on 10/2/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

protocol SectionHeaderViewDelegate {
    func toggleSection(header: SectionHeaderView, section: Int)
}

class SectionHeaderView: UITableViewHeaderFooterView {
    var delegate: SectionHeaderViewDelegate?
    var section: Int!
    
    var arrowLabel = UILabel()
    var radioButonImageView = UIImageView()
    
    var shadowLayer: CAShapeLayer!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer) {
        let cell = gestureRecognizer.view as! SectionHeaderView
        
        delegate?.toggleSection(header: self, section: cell.section)
    }
    
    func customInit(title: String, section: Int, delegate: SectionHeaderViewDelegate, checked: Bool) {
//        self.textLabel!.text = title
        radioButonImageView = UIImageView()
        radioButonImageView.frame = CGRect(x: 13, y: 12, width: 17, height: 17)
        switch checked {
        case true:
            radioButonImageView.image = UIImage(named: "checkBoxChecked.png")
        case false:
            radioButonImageView.image = UIImage(named: "checkBoxUnchecked.png")
        }
        
        
        self.addSubview(radioButonImageView)
        
        let sectionNameLabel = UILabel()
        sectionNameLabel.frame = CGRect(x: 45, y: 5, width: 200, height: 30)
        sectionNameLabel.text = title
        sectionNameLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightThin)
        
        self.addSubview(sectionNameLabel)
        
        arrowLabel = UILabel()
        arrowLabel.text = "^"
        arrowLabel.font = UIFont(name: arrowLabel.font.fontName, size: 16)
        arrowLabel.frame = CGRect(x: 350, y: 10, width: 30, height: 30)
        
        self.addSubview(arrowLabel)
        
        self.section = section
        self.delegate = delegate
    }
  
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel!.textColor = UIColor.black
        self.contentView.backgroundColor = UIColor.white
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 1).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor
            
            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 2
            
            layer.insertSublayer(shadowLayer, at: 0)
            
        } 
    }
}

extension UIView {
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        self.layer.add(animation, forKey: nil)
    }
}
