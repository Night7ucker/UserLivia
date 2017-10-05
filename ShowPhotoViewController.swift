 //
//  ShowPhotoViewController.swift
//  User
//
//  Created by User on 10/5/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class ShowPhotoViewController: RootViewController {

    @IBOutlet weak var fullPhotoImageViewOutlet: UIImageView!
    var indexOfSelectedCell = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        addBackButtonAndTitleToNavigationBar(title: "Prescription details")
        
        let imageURL = "https://test.liviaapp.com" + RealmDataManager.getPrescriptionListModel()[indexOfSelectedCell].image!
        getImage(pictureUrl: imageURL) { success, image in
            if success {
                self.fullPhotoImageViewOutlet.image = image
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
