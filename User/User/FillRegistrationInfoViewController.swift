//
//  FillRegistrationInfoViewController.swift
//  User
//
//  Created by User on 9/23/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import RealmSwift

class FillRegistrationInfoViewController: RootViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, PopupTitleForPersonViewControllerDelegate {
    
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
    @IBOutlet weak var nextLabelOutlet: UILabel!
    
    
    
    @IBOutlet weak var enterYourNameErrorViewOutlet: UIView!
    
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
    
    @IBOutlet weak var wrongEmailRedCircle: UILabel!
    
    
    var isEmailTextField = false
    
    var nameFieldIsEmpty = false
    var surnameFieldIsEmpty = false
    var ageFieldIsEmpty = false
    var emailFieldIsEmplty = false
    
    var nameFieldErrorAppear = false
    var surnameFieldErrorAppear = false
    var ageFieldErrorAppear = false
    var emailFieldErrorAppear = false
    
    var arrayOfFields = [Bool]()
    
    var indexOfCountry = Int()
    
    var avatarToken : NotificationToken?
    
    let loadingAnimationStroyboard = UIStoryboard(name: "LoadingAnimation", bundle: nil)
    var loadingAnimationViewController = LoadingAnimationViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayOfFields.append(nameFieldIsEmpty)
        arrayOfFields.append(surnameFieldIsEmpty)
        arrayOfFields.append(ageFieldIsEmpty)
        arrayOfFields.append(emailFieldIsEmplty)
        
        loadingAnimationViewController = (loadingAnimationStroyboard.instantiateViewController(withIdentifier: "kLoadingAnimationViewController") as? LoadingAnimationViewController)!
        
        setErrorViewsHidden()
        hideKeyboardWhenTappedAround()
        
        configureNavigationBar()
        createTitleInNavigtaionBar(title: "Create profile")
        
        personTitleLabelOutlet.text = "Dr."
        
        nextButtonOutlet.layer.cornerRadius = 2
        nextButtonOutlet.backgroundColor = Colors.Root.lightBlueColor
        nextButtonOutlet.isHidden = true
        nextLabelOutlet.layer.cornerRadius = 2
        
        emailTextFieldOutlet.delegate = self
        firstNameTextFieldOutlet.delegate = self
        lastNameTextFieldOutlet.delegate = self
        ageTextFieldOutlet.delegate = self
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if isEmailTextField {
                if self.view.frame.origin.y == 0{
                    self.view.frame.origin.y -= 60
                    isEmailTextField = false
                }
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += 60
            }
        }
    }
    
    @IBAction func check18YearsOldButtonTapped(_ sender: UIButton) {
        if agreeWithTermsIsChecked {
            check18YearsOldImageViewOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            agreeWithTermsIsChecked = false
        } else {
            check18YearsOldImageViewOutlet.image = UIImage(named: "checkBoxChecked.png")
            agreeWithTermsIsChecked = true
        }
        if checkIfCheksAreSet(check18YearsOld: yearsOld18IsChecked, checkAgreeWithTermsAndConditions: agreeWithTermsIsChecked) {
            nextLabelOutlet.isHidden = true
            nextButtonOutlet.isHidden = false
        } else {
            nextLabelOutlet.isHidden = false
            nextButtonOutlet.isHidden = true
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
        if checkIfCheksAreSet(check18YearsOld: yearsOld18IsChecked, checkAgreeWithTermsAndConditions: agreeWithTermsIsChecked) {
            nextLabelOutlet.isHidden = true
            nextButtonOutlet.isHidden = false
        } else {
            nextLabelOutlet.isHidden = false
            nextButtonOutlet.isHidden = true
        }
    }
    
    func checkIfCheksAreSet(check18YearsOld: Bool, checkAgreeWithTermsAndConditions: Bool) -> Bool {
        if check18YearsOld == false || checkAgreeWithTermsAndConditions == false {
            return false
        }
        return true
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
    
    func checkIfFieldsAreFilled() -> Bool {
        var isFieldsFilled = true
        if firstNameTextFieldOutlet.text == "" {
            isFieldsFilled = false
            nameFieldIsEmpty = true
            enterYourNameExclamationPointOutlet.isHidden = false
            enterYourNameErrorArrowOutlet.isHidden = false
            enterYourNameRedCircleOutlet.isHidden = false
            enterYourNameErrorViewOutlet.isHidden = false
        }
        if lastNameTextFieldOutlet.text == "" {
            isFieldsFilled = false
            surnameFieldIsEmpty = true
            enterYourSurnameViewOutlet.isHidden = false
            enterYourSurnameRedCircleOutlet.isHidden = false
            enterYourSurnameErrorArrowOutlet.isHidden = false
            enterYourSurnameExclamationPointOutlet.isHidden = false
        }
        if ageTextFieldOutlet.text == "" {
            isFieldsFilled = false
            ageFieldIsEmpty = true
            enterYourAgeViewOutlet.isHidden = false
            enterYourAgeRedCircleOutlet.isHidden = false
            enterYourAgeErrorArrowOutlet.isHidden = false
            enterYourAgeExclamationPointOutlet.isHidden = false
        }
        if emailTextFieldOutlet.text == "" {
            isFieldsFilled = false
            emailFieldIsEmplty = true
            wrongEmailRedCircle.isHidden = false
            wrongEmailViewOutlet.isHidden = false
            wrongEmailErrorArrowOutlet.isHidden = false
            wrongEmailExclamationPointOutlet.isHidden = false
        }
        return isFieldsFilled
    }
    
    func getEmptyTextFields() -> [Bool] {
        
        var textFieldsAreFilled = [Bool]()
        var emptyFields = [Bool]()
        
        textFieldsAreFilled.append(nameFieldIsEmpty)
        textFieldsAreFilled.append(surnameFieldIsEmpty)
        textFieldsAreFilled.append(ageFieldIsEmpty)
        textFieldsAreFilled.append(emailFieldIsEmplty)
        
        for field in textFieldsAreFilled {
            if field == false {
                emptyFields.append(field)
            }
        }
        
        return emptyFields
    }
    
    @IBAction func registerUserAction(_ sender: UIButton) {
        if checkIfFieldsAreFilled() {
            present(loadingAnimationViewController, animated: false, completion: nil)
            
            if RealmDataManager.getImageUrlFromRealm().count != 0 {
                let userRegistrationObject = RegistrationUserRequest()
                userRegistrationObject.registerUserFunc(prefixName: personTitleLabelOutlet.text!,
                                                        fName: firstNameTextFieldOutlet.text!,
                                                        lName: lastNameTextFieldOutlet.text!,
                                                        age: ageTextFieldOutlet.text!,
                                                        sex: sex,
                                                        mail: emailTextFieldOutlet.text!,
                                                        imageUrl: RealmDataManager.getImageUrlFromRealm()[0].imageUrl!,
                                                        codeIndex: indexOfCountry) { success in
                                                            if success {
                                                                self.loadingAnimationViewController.dismiss(animated: false) {
                                                                    let chooseCityStoryboard = UIStoryboard(name: "MainViewsStoryboard", bundle: Bundle.main)
                                                                    let chooseCityController = chooseCityStoryboard.instantiateViewController(withIdentifier: "kSearchForItemsViewController") as! SearchForItemsViewController
                                                                    self.navigationController?.pushViewController(chooseCityController, animated: true)
                                                                }
                                                            }
                }
            } else {
                addTokenOnImageUploading()
            }
        } else {
            nameFieldErrorAppear = true
            surnameFieldErrorAppear = true
            ageFieldErrorAppear = true
            emailFieldErrorAppear = true
        }
    }
    
    func addTokenOnImageUploading() {
        let imageUploadRealmObject = RealmDataManager.getImageUrlFromRealm()
        
        avatarToken = imageUploadRealmObject.addNotificationBlock { change in
            switch change {
            case .update:
                self.loadingAnimationViewController.dismiss(animated: false) {
                    self.registerUserAction(UIButton())
                }
            default:
                break
            }
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var imageStr = ""
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        photoImageView.image = selectedImage
        let imageData = UIImagePNGRepresentation(selectedImage)! as NSData
        imageStr = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        let uploadImageObject = UploadImageRequest()
        uploadImageObject.uploadImage(imageString: imageStr)
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func termsAndConditionsLinkTapped(_ sender: UIButton) {
        let termsAndConditions = UIStoryboard(name: "TermsAndConditions", bundle: nil)
        let termsAndConditionsViewController = termsAndConditions.instantiateViewController(withIdentifier: "kTermsAndConditionsWebViewViewController") as? TermsAndConditionsWebViewViewController
        navigationController?.pushViewController(termsAndConditionsViewController!, animated: true)
    }
    
    func trasferUsetTitle(personTitle: String) {
        personTitleLabelOutlet.text = personTitle
    }
    
    func setErrorViewsHidden() {
        enterYourNameErrorViewOutlet.isHidden = true
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
        
        wrongEmailRedCircle.isHidden = true
        wrongEmailViewOutlet.isHidden = true
        wrongEmailErrorArrowOutlet.isHidden = true
        wrongEmailExclamationPointOutlet.isHidden = true
    }
    
    // showPopupWithTitlesForRegistration
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPopupWithTitlesForRegistration" {
            let popupTitleForPersonViewController = segue.destination as? PopupTitleForPersonViewController
            popupTitleForPersonViewController?.delegate = self
        }
    }
    
}

extension FillRegistrationInfoViewController: UITextFieldDelegate  {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextFieldOutlet {
            isEmailTextField = true
            if emailFieldErrorAppear {
                wrongEmailExclamationPointOutlet.isHidden = true
                wrongEmailErrorArrowOutlet.isHidden = true
                wrongEmailViewOutlet.isHidden = true
                wrongEmailRedCircle.isHidden = true
                emailFieldErrorAppear = false
            }
        }
        if textField == firstNameTextFieldOutlet {
            if nameFieldErrorAppear {
                enterYourNameErrorViewOutlet.isHidden = true
                enterYourNameRedCircleOutlet.isHidden = true
                enterYourNameErrorArrowOutlet.isHidden = true
                enterYourNameExclamationPointOutlet.isHidden = true
                nameFieldErrorAppear = false
            }
        }
        if textField == ageTextFieldOutlet {
            if ageFieldErrorAppear {
                enterYourAgeExclamationPointOutlet.isHidden = true
                enterYourAgeErrorArrowOutlet.isHidden = true
                enterYourAgeRedCircleOutlet.isHidden = true
                enterYourAgeViewOutlet.isHidden = true
                ageFieldErrorAppear = false
            }
        }
        if textField == lastNameTextFieldOutlet {
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
