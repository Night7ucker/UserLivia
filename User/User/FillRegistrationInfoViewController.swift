//
//  FillRegistrationInfoViewController.swift
//  User
//
//  Created by User on 9/23/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import RealmSwift

class FillRegistrationInfoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var token = NotificationToken()
    let realm = try! Realm()
    
    var yearsOld18IsChecked = false
    var agreeWithTermsIsChecked = false
    var imagePicker = UIImagePickerController()
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet weak var personTitleLabelOutlet: UILabel!
    @IBOutlet weak var firstNameTextFieldOutlet: UITextField!
    @IBOutlet weak var lastNameTextFieldOutlet: UITextField!
    @IBOutlet weak var ageTextFieldOutlet: UITextField!
    @IBOutlet weak var emailTextFieldOutlet: UITextField!
    @IBOutlet weak var check18YearsOldImageViewOutlet: UIImageView!
    @IBOutlet weak var checkTermsAndConditionsImageViewOutlet: UIImageView!
    @IBOutlet weak var nextButtonOutlet: UIButton!
    @IBOutlet weak var openTermsLinkButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.4, green: 0.8, blue: 0.7, alpha: 1)
        
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        navigationController?.navigationBar.layer.shadowRadius = 4.0
        navigationController?.navigationBar.layer.shadowOpacity = 0.5
        navigationController?.navigationBar.layer.masksToBounds = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Create profile"
        titleLabel.textColor = .white
        titleLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        
        let titleLabelBarButton = UIBarButtonItem(customView: titleLabel)
        
        navigationItem.leftBarButtonItem = titleLabelBarButton
        
         if RealmDataManager.getPersonTitleFromRealm().count > 0 {
            try! realm.write {
                realm.delete(RealmDataManager.getPersonTitleFromRealm())
            }
        }
        nextButtonOutlet.layer.cornerRadius = 2
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
       
        token = realm.addNotificationBlock { (notifcation, realm) -> Void in
            
            if RealmDataManager.getPersonTitleFromRealm().count > 0 {
                self.personTitleLabelOutlet.text = RealmDataManager.getPersonTitleFromRealm()[0].title
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    deinit {
        token.stop()
    }

    @IBAction func check18YearsOldButtonTapped(_ sender: UIButton) {
        if agreeWithTermsIsChecked {
            check18YearsOldImageViewOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            agreeWithTermsIsChecked = false
        } else {
            check18YearsOldImageViewOutlet.image = UIImage(named: "checkBoxChecked.png")
            agreeWithTermsIsChecked = true
        }
    }
    
    
    @IBAction func agreeWithTermsButtonTapped(_ sender: UIButton) {
        if yearsOld18IsChecked {
            checkTermsAndConditionsImageViewOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            yearsOld18IsChecked = false
        } else {
            checkTermsAndConditionsImageViewOutlet.image = UIImage(named: "checkBoxChecked.png")
            yearsOld18IsChecked = true
        }
    }
    
    @IBAction func changeTitleButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func changeSexSegmentedControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            print("female")
        } else if sender.selectedSegmentIndex == 1 {
            print("male")
        }
    }
    @IBAction func addPhotoAction(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
    
        }
    }
    
    
    @IBAction func registerUserAction(_ sender: UIButton) {
        
    }
    
    var imageStr = ""
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        photoImageView.image = selectedImage
        
        let queue = OperationQueue()
        
        queue.addOperation {
            let imageData = UIImagePNGRepresentation(selectedImage)! as NSData
            self.imageStr = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            queue.addOperation {
                let obj = UploadImageRequest()
                obj.uploadImage(imageString: self.imageStr)
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
 
}
