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
    var sex = "Female"
    
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
    
    var indexOfCountry = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = "Registration Fields"
        print(indexOfCountry)
        
        if RealmDataManager.getPersonTitleFromRealm().count > 0 {
            try! realm.write {
                realm.delete(RealmDataManager.getPersonTitleFromRealm())
            }
        }
        let titlePersonObject = PersonTitleModel()
        titlePersonObject.title = "Dr."
        RealmDataManager.writeIntoRealm(object: titlePersonObject, realm: realm)
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
            sex = "Female"
        } else if sender.selectedSegmentIndex == 1 {
            sex = "Male"
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
        
        let userRegistrationObject = RegistrationUserRequest()
        userRegistrationObject.uploadImage(fName: firstNameTextFieldOutlet.text!,
                        lName: lastNameTextFieldOutlet.text!,
                        age: ageTextFieldOutlet.text!,
                        sex: sex,
                        mail: emailTextFieldOutlet.text!,
                        imageUrl: RealmDataManager.getImageUrlFromRealm()[0].imageUrl!,
                        codeIndex: indexOfCountry) { success in
                            if success {
                                let mainScreenStoryboard = UIStoryboard(name: "MainScreen", bundle: nil)
                                let mainScreenViewController = mainScreenStoryboard.instantiateViewController(withIdentifier: "kMainScreenController") as? MainScreenController
                                self.navigationController?.pushViewController(mainScreenViewController!, animated: true)
                            }
        }
        
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
