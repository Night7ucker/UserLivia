//
//  OrderDescriptionTableViewCell.swift
//  User
//
//  Created by BAMFAdmin on 04.10.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class OrderDescriptionTableViewCell: UITableViewCell {

    @IBOutlet var drugsReceptImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


/*
 override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 self.selectedIndex = indexPath
 self.didExpandCell()
 
 }
 func didExpandCell() {
 self.isExpanded = !isExpanded
 self.tableView.reloadRows(at: [selectedIndex!], with: .automatic)
 }
 
 override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
 if isExpanded && self.selectedIndex == indexPath {
 if indexPath.row == 0 {
 return 565
 }
 }
 if indexPath.row == 1 {
 return 250
 }
 return 60
 }
*/
 
 
