//
//  BottomPopupForPrescriptionVC.swift
//  User
//
//  Created by User on 10/4/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class BottomPopupForPrescriptionVC: RootViewController {
    
    var delegate: BottomPopupForPrescriptionVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: false, completion: nil)
    }

    @IBAction func getPhotoFromGalleryButtonTapped(_ sender: UIButton) {
        dismiss(animated: false) {
            self.delegate.showImagePickerGallery()
        }
    }
    
    
    
    @IBAction func takePhotoButtonTapped(_ sender: UIButton) {
        dismiss(animated: false) {
            self.delegate.showImagePickerCamera()
        }
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
