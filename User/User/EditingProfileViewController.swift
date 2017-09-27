//
//  EditingProfileViewController.swift
//  User
//
//  Created by User on 9/26/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import RealmSwift

protocol PopupTitleForPersonViewControllerDelegate: class {
    func trasferUsetTitle(personTitle: String)
}

class EditingProfileViewController: UIViewController, PopupTitleForPersonViewControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var userAvatarImageOutlet: UIImageView!
    
    @IBOutlet weak var userTitleLabelOutlet: UILabel!
    
    @IBOutlet weak var userNameTextFieldOutlet: UITextField!
    
    @IBOutlet weak var userLastnameTextFieldOutlet: UITextField!
    
    @IBOutlet weak var userCityLabelOutlet: UILabel!
    

    @IBOutlet weak var userAgeTextFieldOutlet: UITextField!
    
    @IBOutlet weak var userSexSegmentedControlOutlet: UISegmentedControl!
    
    @IBOutlet weak var userEmailTextFieldOutlet: UITextField!
    
    
    @IBOutlet weak var userCountryLabelOutlet: UILabel!
    
    @IBOutlet weak var userCountryImageViewOutlet: UIImageView!
    
    @IBOutlet weak var userCountryPhoneCodeLabelOutlet: UILabel!
    
    @IBOutlet weak var userPhoneNumberLabelOutlet: UILabel!
    
    var sex = "Female"
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        backButton.setTitle("", for: .normal)
        backButton.setBackgroundImage(UIImage(named: "backButtonImage"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)

        let backButtonBarButton = UIBarButtonItem(customView: backButton)
        
        let titleLabel = UILabel()
        titleLabel.text = "My account"
        titleLabel.textColor = .white
        titleLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        let titleLabelBarButton = UIBarButtonItem(customView: titleLabel)
        
        navigationItem.setLeftBarButtonItems([backButtonBarButton, titleLabelBarButton], animated: true)
        
        let addReminderButton = UIButton(type: .system)
        addReminderButton.frame = CGRect(x: 300, y: 0, width: 70, height: 100)
        addReminderButton.setTitle("✓", for: .normal)
        addReminderButton.titleLabel?.font = UIFont(name: "Arial", size: 25)
        addReminderButton.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: UIFontWeightThin)
        addReminderButton.setTitleColor(.white, for: .normal)
        addReminderButton.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 0, -60)
        addReminderButton.addTarget(self, action: #selector(confrimedTapped(_ :)), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addReminderButton)
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.4, green: 0.8, blue: 0.7, alpha: 1)
        
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        navigationController?.navigationBar.layer.shadowRadius = 4.0
        navigationController?.navigationBar.layer.shadowOpacity = 0.5
        navigationController?.navigationBar.layer.masksToBounds = false
        
        userTitleLabelOutlet.text = RealmDataManager.getUserDataFromRealm()[0].namePrefix!
        userNameTextFieldOutlet.text = RealmDataManager.getUserDataFromRealm()[0].firstName!
        userLastnameTextFieldOutlet.text = RealmDataManager.getUserDataFromRealm()[0].lastName!
        userAgeTextFieldOutlet.text = RealmDataManager.getUserDataFromRealm()[0].age!
        if RealmDataManager.getUserDataFromRealm()[0].sex == "Male" {
            userSexSegmentedControlOutlet.selectedSegmentIndex = 1
        } else {
            userSexSegmentedControlOutlet.selectedSegmentIndex = 0
        }
        userEmailTextFieldOutlet.text = RealmDataManager.getUserDataFromRealm()[0].email!
        userCountryLabelOutlet.text = "Belarus"
            let countryImageObject = CountryCodesDataManager()
            countryImageObject.getImage(pictureUrl: "https://test.liviaapp.com/images/flags/32x32/by.png") { success, image in
                if success {
                    self.userCountryImageViewOutlet.image = image
                }
        }
        userCountryPhoneCodeLabelOutlet.text = RealmDataManager.getUserDataFromRealm()[0].countryCode!
        userPhoneNumberLabelOutlet.text =  RealmDataManager.getUserDataFromRealm()[0].phoneNumber!
        
        let avatarImageObject = CountryCodesDataManager()
        let fullAvatarUrl = "https://test.liviaapp.com"+RealmDataManager.getUserDataFromRealm()[0].avatar!
        avatarImageObject.getImage(pictureUrl: fullAvatarUrl) { success, image in
            if success {
                self.userAvatarImageOutlet.image = image
            }
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
    
    func confrimedTapped(_ sender: UIButton) {
       
        let realmObjectToSave = RealmDataManager.getUserDataFromRealm()
        let realm = try! Realm()

        try! realm.write {
            realmObjectToSave[0].namePrefix = userTitleLabelOutlet.text
            realmObjectToSave[0].firstName = userNameTextFieldOutlet.text
            realmObjectToSave[0].lastName = userLastnameTextFieldOutlet.text
            realmObjectToSave[0].age = userAgeTextFieldOutlet.text
            realmObjectToSave[0].email = userEmailTextFieldOutlet.text
            realmObjectToSave[0].sex = sex
            realmObjectToSave[0].avatar = RealmDataManager.getImageUrlFromRealm()[0].imageUrl!
        }
            let obj = EditUserProfileRequest()
            obj.editUserFunc { (success) in
                if success {
                    let MainScreenStoryboard = UIStoryboard(name: "MainScreen", bundle: Bundle.main)
                    let MainScreenController = MainScreenStoryboard.instantiateViewController(withIdentifier: "kMainScreenController") as! MainScreenController
                    MainScreenController.userIsRegistred = true
                    self.navigationController?.pushViewController(MainScreenController, animated: true)
                }
        }
       
    }
    
    
    @IBAction func userChangeTitleButtonTapped(_ sender: UIButton) {
        let registrationModule = UIStoryboard(name: "RegistrationModule", bundle: nil)
        let popupTitleForPersonViewController = registrationModule.instantiateViewController(withIdentifier: "kPopupTitleForPersonViewController") as? PopupTitleForPersonViewController
        popupTitleForPersonViewController?.delegate = self
        present(popupTitleForPersonViewController!, animated: false, completion: nil)
    }
    
    func trasferUsetTitle(personTitle: String) {
        userTitleLabelOutlet.text = personTitle
    }

    @IBAction func changeSexSegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            sex = "Female"
        case 1:
            sex = "Male"
        default:
            break
        }
    }
    
    @IBAction func changeUserPictureButtonTapped(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
            
        }
        
    }
    
    var imageStr = ""
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        userAvatarImageOutlet.image = selectedImage
    
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
