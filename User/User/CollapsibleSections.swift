//
//  CollapsibleSections.swift
//  User
//
//  Created by User on 9/28/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

protocol CollapsibleTableViewHeaderDelegate {
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int)
}

class CollapsibleTableViewHeader: UITableViewHeaderFooterView {
    var delegate: CollapsibleTableViewHeaderDelegate?
    var section: Int = 0
    
    let titleLabel = UILabel()
    let arrowLabel = UILabel()
    let radioButtonImageView = UIImageView()
    let optionalCostLabel = UILabel()
    
    let lightBluecolor = UIColor( red: CGFloat(0/255.0), green: CGFloat(128/255.0), blue: CGFloat(255/255.0), alpha: CGFloat(1.0) )
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CollapsibleTableViewHeader.tapHeader(_:))))
        
        // Arrow label
        contentView.addSubview(arrowLabel)
        arrowLabel.textColor = UIColor.black
        arrowLabel.frame = CGRect(x: 350, y: 8, width: 15, height: 15)
        
        contentView.addSubview(radioButtonImageView)
        radioButtonImageView.frame = CGRect(x: 18, y: 7, width: 20, height: 20)
        
        // Title label
        contentView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.black
        titleLabel.frame = CGRect(x: 50, y: 5, width: 150, height: 25)
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 14)
        
        contentView.addSubview(optionalCostLabel)
        optionalCostLabel.frame = CGRect(x: 108, y: 5, width: 120, height: 25)
        optionalCostLabel.font = UIFont(name: optionalCostLabel.font.fontName, size: 14)
        optionalCostLabel.textColor = lightBluecolor
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? CollapsibleTableViewHeader else {
            return
        }
        delegate?.toggleSection(self, section: cell.section)
    }
    
    func setCollapsed(_ collapsed: Bool) {
        arrowLabel.rotate(collapsed ? 0.0 : .pi / 2)
    }
}
