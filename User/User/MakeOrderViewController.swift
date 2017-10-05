//
//  MakeOrderViewController.swift
//  User
//
//  Created by User on 9/22/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

protocol BottomPopupForPrescriptionVCDelegate {
    func showImagePickerGallery()
    func showImagePickerCamera()
}

class MakeOrderViewController: RootViewController, BottomPopupForPrescriptionVCDelegate {
    
    @IBOutlet weak var makeOrderTableView: UITableView!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        addBackButtonAndTitleToNavigationBar(title: "Request price")
        
        makeOrderTableView.layer.cornerRadius = 10
        makeOrderTableView.dataSource = self
        makeOrderTableView.delegate = self
        
        picker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showImagePickerGallery() {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    func showImagePickerCamera() {
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            
            let alertController = UIAlertController.init(title: nil, message: "Device has no camera.", preferredStyle: .alert)
            
            let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: {(alert: UIAlertAction!) in
            })
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        else{
            picker.allowsEditing = false
            picker.sourceType = .camera
            picker.cameraCaptureMode = .photo
        }
        
    }
    
    @IBAction func shootPhoto(_ sender: UIBarButtonItem) {
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerControllerSourceType.camera
        picker.cameraCaptureMode = .photo
        picker.modalPresentationStyle = .fullScreen
        present(picker,animated: true,completion: nil)
    }
}

extension MakeOrderViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "makeOrderCell", for: indexPath) as! MakeOrderCellTableViewCell
            
            cell.fillCellInfo(topImage: UIImage(named: "makeOrderPhoto")!, bottomImage: UIImage(named: "cameraFromMakeOrder")!, topMenuLabelOutletText: "Take a Photo of Prescription", bottomMenuLabelOutletText: "GENERATE ORDER FROM YOUR PHOTO")
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "makeOrderCell", for: indexPath) as! MakeOrderCellTableViewCell
            
            cell.fillCellInfo(topImage: UIImage(named: "makeOrderPhoto")!, bottomImage: UIImage(named: "searchFromMakeOrder")!, topMenuLabelOutletText: "Search for medicines / items", bottomMenuLabelOutletText: "SEARCH FROM 1003 DRUGS")
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            switch indexPath.row {
            case 0:
                let takePhotoOfPrescriptionStoryboard = UIStoryboard(name: "TakePhotoOfPrescription", bundle: nil)
                let bottomPopupForCameraVC = takePhotoOfPrescriptionStoryboard.instantiateViewController(withIdentifier: "kBottomPopupForPrescriptionVC") as! BottomPopupForPrescriptionVC
                bottomPopupForCameraVC.delegate = self
                self.present(bottomPopupForCameraVC, animated: false)
            case 1:
                let GetDrugsStoryboard = UIStoryboard(name: "SearchDrugs", bundle: nil)
                let GetDrugsViewController = GetDrugsStoryboard.instantiateViewController(withIdentifier: "kSearchDrugsStoryboardId") as? GetDrugsViewController
                self.navigationController?.pushViewController(GetDrugsViewController!, animated: true)
            default:
                break
            }
        }
    }
}

extension MakeOrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension MakeOrderViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var imageStr = ""
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imageData = UIImagePNGRepresentation(selectedImage)! as NSData
        imageStr = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        let uploadImageObject = UploadImageRequest()

        dismiss(animated: true) {
            let loadingAnimationStoryboard = UIStoryboard(name: "LoadingAnimation", bundle: nil)
            let loadingAnimationViewController = loadingAnimationStoryboard.instantiateViewController(withIdentifier: "kLoadingAnimationViewController") as! LoadingAnimationViewController
            self.present(loadingAnimationViewController, animated: false)
            
            uploadImageObject.uploadImage(imageString: imageStr) { success in
                if success {
                    loadingAnimationViewController.dismiss(animated: false) {
                        let selectOrderTypeStoryboard = UIStoryboard(name: "SelectOrderType", bundle: nil)
                        let selectOrderTypeViewController = selectOrderTypeStoryboard.instantiateViewController(withIdentifier: "kExpandedViewController") as! ExpandedViewController
                        self.navigationController?.pushViewController(selectOrderTypeViewController, animated: false)
                    }
                    
                }
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
