//
//  DoctorsPhotosCell.swift
//  User
//
//  Created by User on 10/18/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class DoctorsPhotosCell: UITableViewCell {

    @IBOutlet weak var photosCollectionViewOutlet: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDataSource & UICollectionViewDelegate>
        (dataSourceDelegate: D) {
        
        photosCollectionViewOutlet.delegate = dataSourceDelegate
        photosCollectionViewOutlet.dataSource = dataSourceDelegate
        photosCollectionViewOutlet.reloadData()
    }

}
