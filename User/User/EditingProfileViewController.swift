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

class EditingProfileViewController: RootViewController, PopupTitleForPersonViewControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var userAvatarImageOutlet: UIImageView!
    @IBOutlet weak var userTitleLabelOutlet: UILabel!
    @IBOutlet weak var userNameTextFieldOutlet: UITextField!
    @IBOutlet weak var userLastnameTextFieldOutlet: UITextField!
    @IBOutlet weak var userCityLabelOutlet: UILabel!
    @IBOutlet var changeCityButtonOutlet: UIButton!
    @IBOutlet weak var userAgeTextFieldOutlet: UITextField!
    @IBOutlet weak var userSexSegmentedControlOutlet: UISegmentedControl!
    @IBOutlet weak var userEmailTextFieldOutlet: UITextField!
    @IBOutlet weak var userCountryLabelOutlet: UILabel!
    @IBOutlet weak var userCountryImageViewOutlet: UIImageView!
    @IBOutlet weak var userCountryPhoneCodeLabelOutlet: UILabel!
    @IBOutlet weak var userPhoneNumberLabelOutlet: UILabel!
    
    
    @IBOutlet weak var enterYourNameViewOutlet: UIView!
    
    @IBOutlet weak var enterYourNameErrorArrowOutlet: UILabel!
    
    @IBOutlet weak var enterYourNameExclamationPointOutlet: UILabel!
    
    @IBOutlet weak var enterYourNameRedCircleOutlet: UILabel!
    
    
    
    @IBOutlet weak var enterYourSurnameViewOutlet: UIView!
    
    
    @IBOutlet weak var enterYourSurnameErrorArrowOutlet: UILabel!
    
    @IBOutlet weak var enterYourSurnameExclamationPointOutlet: UILabel!
    
    @IBOutlet weak var enterYourSurnameRedCircleOutlet: UILabel!
    
    
    @IBOutlet weak var enterYourAgeViewOutlet: UIView!
    
    
    @IBOutlet weak var enterYourAgeErrorArrowOutlet: UILabel!
    
    
    @IBOutlet weak var enterYourAgeExclamationPointOutlet: UILabel!
    
    @IBOutlet weak var enterYourAgeRedCircleOutlet: UILabel!
    
    
    
    @IBOutlet weak var wrongEmailViewOutlet: UIView!
    
    
    @IBOutlet weak var wrongEmailErrorArrowOutlet: UILabel!
    
    
    @IBOutlet weak var wrongEmailExclamationPointOutlet: UILabel!
    
    @IBOutlet weak var wrongEmailRedCircleOutlet: UILabel!
    
    var nameFieldIsEmpty = false
    var surnameFieldIsEmpty = false
    var ageFieldIsEmpty = false
    var emailFieldIsEmplty = false
    
    var nameFieldErrorAppear = false
    var surnameFieldErrorAppear = false
    var ageFieldErrorAppear = false
    var emailFieldErrorAppear = false
    
    var sex = "Female"
    var imagePicker = UIImagePickerController()
    
    var avatarToken : NotificationToken?
    
    let loadingAnimationStroyboard = UIStoryboard(name: "LoadingAnimation", bundle: nil)
    var loadingAnimationViewController = LoadingAnimationViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        addBackButtonAndTitleToNavigationBar(title: "My account")
        addCompleteChangesButtonAsRightBarButtonItem()
        
        userLastnameTextFieldOutlet.delegate = self
        userNameTextFieldOutlet.delegate = self
        userEmailTextFieldOutlet.delegate = self
        userAgeTextFieldOutlet.delegate = self
        setErrorViewsHidden()
        
        loadingAnimationViewController = (loadingAnimationStroyboard.instantiateViewController(withIdentifier: "kLoadingAnimationViewController") as? LoadingAnimationViewController)!
        
        let imageUploadRealmObject = RealmDataManager.getImageUrlFromRealm()
        
        avatarToken = imageUploadRealmObject.addNotificationBlock { change in
            switch change {
            case .update:
                self.loadingAnimationViewController.dismiss(animated: false, completion: nil)
                self.confrimedTapped(UIButton())
            default:
                break
            }
        }
        
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
            getImage(pictureUrl: "https://test.liviaapp.com/images/flags/32x32/by.png") { success, image in
                if success {
                    self.userCountryImageViewOutlet.image = image
                }
        }
        userCountryPhoneCodeLabelOutlet.text = RealmDataManager.getUserDataFromRealm()[0].phoneCode
        userPhoneNumberLabelOutlet.text =  RealmDataManager.getUserDataFromRealm()[0].phoneNumber!
        
        if RealmDataManager.getUserDataFromRealm()[0].avatar != nil {
        let fullAvatarUrl = "https://test.liviaapp.com"+RealmDataManager.getUserDataFromRealm()[0].avatar!

            getImage(pictureUrl: fullAvatarUrl) { success, image in
                if success {
                    self.userAvatarImageOutlet.image = image
                }
            }
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        userCityLabelOutlet.text = RealmDataManager.getUserDataFromRealm()[0].cityName!+", "+RealmDataManager.getUserDataFromRealm()[0].countryName!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    deinit {
        avatarToken?.stop()
    }
    
    private func addCompleteChangesButtonAsRightBarButtonItem() {
        let addReminderButton = UIButton(type: .system)
        addReminderButton.frame = CGRect(x: 300, y: 0, width: 70, height: 100)
        addReminderButton.setTitle("✓", for: .normal)
        addReminderButton.titleLabel?.font = UIFont(name: "Arial", size: 25)
        addReminderButton.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: UIFontWeightThin)
        addReminderButton.setTitleColor(.white, for: .normal)
        addReminderButton.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 0, -60)
        addReminderButton.addTarget(self, action: #selector(confrimedTapped(_ :)), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addReminderButton)
    }
    
    func confrimedTapped(_ sender: UIButton) {
        
        if checkIfFieldsAreFilled() {
            
            present(loadingAnimationViewController, animated: false, completion: nil)
            
            let realmObjectToSave = RealmDataManager.getUserDataFromRealm()
            let realm = try! Realm()
            if RealmDataManager.getImageUrlFromRealm().count != 0 {
                
                try! realm.write {
                    realmObjectToSave[0].namePrefix = userTitleLabelOutlet.text
                    realmObjectToSave[0].firstName = userNameTextFieldOutlet.text
                    realmObjectToSave[0].lastName = userLastnameTextFieldOutlet.text
                    realmObjectToSave[0].age = userAgeTextFieldOutlet.text
                    realmObjectToSave[0].email = userEmailTextFieldOutlet.text
                    realmObjectToSave[0].sex = sex
                    if RealmDataManager.getImageUrlFromRealm().count > 0 {
                        realmObjectToSave[0].avatar = RealmDataManager.getImageUrlFromRealm()[0].imageUrl!
                    }
                }
                
                let obj = EditUserProfileRequest()
                obj.editUserFunc { (success) in
                    
                    if success {
                        self.loadingAnimationViewController.dismiss(animated: true) {
                            let MainScreenStoryboard = UIStoryboard(name: "MainScreen", bundle: Bundle.main)
                            let MainScreenController = MainScreenStoryboard.instantiateViewController(withIdentifier: "kMainScreenController") as! MainScreenController
                            MainScreenController.userIsRegistred = true
                            self.navigationController?.pushViewController(MainScreenController, animated: true)
                        }
                    }
                }
            }
            
        } else {
            nameFieldErrorAppear = true
            surnameFieldErrorAppear = true
            ageFieldErrorAppear = true
            emailFieldErrorAppear = true
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
    
    
    @IBAction func changeCityAction(_ sender: UIButton) {
        let ChooseCityStoryboard = UIStoryboard(name: "MainViewsStoryboard", bundle: Bundle.main)
        let ChooseCityController = ChooseCityStoryboard.instantiateViewController(withIdentifier: "kSearchForItemsViewController") as! SearchForItemsViewController
        ChooseCityController.checkEditProfile = true
        self.navigationController?.pushViewController(ChooseCityController, animated: true)
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
        let imageData = UIImagePNGRepresentation(selectedImage)! as NSData
        self.imageStr = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        let uploadImageObject = UploadImageRequest()
        uploadImageObject.uploadImage(imageString: self.imageStr)

        dismiss(animated: true, completion: nil)
    }
    
    func checkIfFieldsAreFilled() -> Bool {
        var isFieldsFilled = true
        if userNameTextFieldOutlet.text == "" {
            isFieldsFilled = false
            nameFieldIsEmpty = true
            enterYourNameExclamationPointOutlet.isHidden = false
            enterYourNameErrorArrowOutlet.isHidden = false
            enterYourNameRedCircleOutlet.isHidden = false
            enterYourNameViewOutlet.isHidden = false
        }
        if userLastnameTextFieldOutlet.text == "" {
            isFieldsFilled = false
            surnameFieldIsEmpty = true
            enterYourSurnameViewOutlet.isHidden = false
            enterYourSurnameRedCircleOutlet.isHidden = false
            enterYourSurnameErrorArrowOutlet.isHidden = false
            enterYourSurnameExclamationPointOutlet.isHidden = false
        }
        if userAgeTextFieldOutlet.text == "" {
            isFieldsFilled = false
            ageFieldIsEmpty = true
            enterYourAgeViewOutlet.isHidden = false
            enterYourAgeRedCircleOutlet.isHidden = false
            enterYourAgeErrorArrowOutlet.isHidden = false
            enterYourAgeExclamationPointOutlet.isHidden = false
        }
        if userEmailTextFieldOutlet.text == "" {
            isFieldsFilled = false
            emailFieldIsEmplty = true
            wrongEmailRedCircleOutlet.isHidden = false
            wrongEmailViewOutlet.isHidden = false
            wrongEmailErrorArrowOutlet.isHidden = false
            wrongEmailExclamationPointOutlet.isHidden = false
        }
        return isFieldsFilled
    }

    
    func setErrorViewsHidden() {
        enterYourNameViewOutlet.isHidden = true
        enterYourNameRedCircleOutlet.isHidden = true
        enterYourNameErrorArrowOutlet.isHidden = true
        enterYourNameExclamationPointOutlet.isHidden = true
        
        enterYourSurnameViewOutlet.isHidden = true
        enterYourSurnameRedCircleOutlet.isHidden = true
        enterYourSurnameErrorArrowOutlet.isHidden = true
        enterYourSurnameExclamationPointOutlet.isHidden = true
        
        enterYourAgeExclamationPointOutlet.isHidden = true
        enterYourAgeErrorArrowOutlet.isHidden = true
        enterYourAgeRedCircleOutlet.isHidden = true
        enterYourAgeViewOutlet.isHidden = true
        
        wrongEmailRedCircleOutlet.isHidden = true
        wrongEmailViewOutlet.isHidden = true
        wrongEmailErrorArrowOutlet.isHidden = true
        wrongEmailExclamationPointOutlet.isHidden = true
    }
}

extension EditingProfileViewController: UITextFieldDelegate  {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == userEmailTextFieldOutlet {
//            isEmailTextField = true
            if emailFieldErrorAppear {
                wrongEmailExclamationPointOutlet.isHidden = true
                wrongEmailErrorArrowOutlet.isHidden = true
                wrongEmailViewOutlet.isHidden = true
                wrongEmailRedCircleOutlet.isHidden = true
                emailFieldErrorAppear = false
            }
        }
        if textField == userNameTextFieldOutlet {
            if nameFieldErrorAppear {
                enterYourNameViewOutlet.isHidden = true
                enterYourNameRedCircleOutlet.isHidden = true
                enterYourNameErrorArrowOutlet.isHidden = true
                enterYourNameExclamationPointOutlet.isHidden = true
                nameFieldErrorAppear = false
            }
        }
        if textField == userAgeTextFieldOutlet {
            if ageFieldErrorAppear {
                enterYourAgeExclamationPointOutlet.isHidden = true
                enterYourAgeErrorArrowOutlet.isHidden = true
                enterYourAgeRedCircleOutlet.isHidden = true
                enterYourAgeViewOutlet.isHidden = true
                ageFieldErrorAppear = false
            }
        }
        if textField == userLastnameTextFieldOutlet {
            if surnameFieldErrorAppear {
                enterYourSurnameExclamationPointOutlet.isHidden = true
                enterYourSurnameErrorArrowOutlet.isHidden = true
                enterYourSurnameRedCircleOutlet.isHidden = true
                enterYourSurnameViewOutlet.isHidden = true
                surnameFieldErrorAppear = false
            }
        }
    }
}
