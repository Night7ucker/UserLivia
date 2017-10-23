//
//  CertainDoctorVC.swift
//  User
//
//  Created by User on 10/16/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import RealmSwift
import GoogleMaps

protocol SpecializationsHeaderViewDelegate {
    func specializatinHeaderViewExpand()
}

class CertainDoctorVC: RootViewController, SpecializationsHeaderViewDelegate {
    
    @IBOutlet weak var yearsOutlet: UILabel!
    
    @IBOutlet weak var doctorNameOutlet: UILabel!
    
    @IBOutlet weak var doctorAvatarImageViewOutlet: UIImageView!
    
    @IBOutlet weak var doctorFeeOutlet: UILabel!
    
    @IBOutlet weak var infoAboutDoctorTableViewOutlet: UITableView!
    
    var doctorID: String?
    
    var mappedDoctorInfo: MappedCertainDoctorModel?
    
    var isExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBackButtonAndTitleToNavigationBar(title: "")
        
        infoAboutDoctorTableViewOutlet.delegate = self
        infoAboutDoctorTableViewOutlet.dataSource = self
        
        infoAboutDoctorTableViewOutlet.backgroundColor = Colors.Root.backgroundColor
        infoAboutDoctorTableViewOutlet.tableFooterView = UIView(frame: .zero)
        infoAboutDoctorTableViewOutlet.backgroundColor = .clear
        infoAboutDoctorTableViewOutlet.isHidden = true
        
        doctorAvatarImageViewOutlet.layer.cornerRadius = doctorAvatarImageViewOutlet.frame.size.width/2
        doctorAvatarImageViewOutlet.layer.borderWidth = 2
        doctorAvatarImageViewOutlet.layer.borderColor = UIColor.white.cgColor
        doctorAvatarImageViewOutlet.clipsToBounds = true
        
        GetCertainDoctorRequest.getCertainDoctor(doctorID: doctorID!) { success in
            if success {
                self.mappedDoctorInfo = RealmDataManager.getCertainDoctorFromRealm()[0]
                self.infoAboutDoctorTableViewOutlet.reloadData()
                self.infoAboutDoctorTableViewOutlet.isHidden = false
                self.yearsOutlet.text = self.mappedDoctorInfo?.experienceYears
                self.doctorNameOutlet.text = self.mappedDoctorInfo?.name
                self.doctorFeeOutlet.text = self.mappedDoctorInfo?.consultationFees
                if self.mappedDoctorInfo?.avatar != nil {
                    let imageURL = "https://test.liviaapp.com" + (self.mappedDoctorInfo?.avatar)!
                    self.getImage(pictureUrl: imageURL) { success, image in
                        if success {
                            self.doctorAvatarImageViewOutlet.image = image
                        }
                    }
                }
            }
        }
        
        let nib = UINib(nibName: "SpecializationsHeader", bundle: nil)
        infoAboutDoctorTableViewOutlet.register(nib, forHeaderFooterViewReuseIdentifier: "SpecializationsHeader")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func specializatinHeaderViewExpand() {
        isExpanded = !isExpanded
        infoAboutDoctorTableViewOutlet.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .automatic)
    }
    
    @objc func seeAllButtonTapped(_ sender: UIButton) {
        print("see ALL Button tapped")
    }
}

extension CertainDoctorVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if mappedDoctorInfo?.doctorsPhotos.count == 0 {
            return 3
        }
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if mappedDoctorInfo != nil {
                return (mappedDoctorInfo?.receptionPhoneNumbers.count)!
            } else {
                return 0
            }
        default:
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if mappedDoctorInfo != nil {
            switch indexPath.section {
            case 0:
                guard let doctorPhoneCell = tableView.dequeueReusableCell(withIdentifier: "doctorPhoneCell") as? DoctorPhoneCell else { return  UITableViewCell() }
                
                doctorPhoneCell.doctorPhoneNumberLabelOutlet.text = "+" + (mappedDoctorInfo?.receptionPhoneNumbers[indexPath.row].stringValue)!
                
                doctorPhoneCell.doctorPhoneNumberLabelOutlet.textColor = Colors.Root.lightBlueColor
                doctorPhoneCell.backgroundColor = .white
                
                return doctorPhoneCell
            case 1:
                guard let clinicsInfoCell = tableView.dequeueReusableCell(withIdentifier: "clinicsInfoCell") as? ClinicsInfoCell else { return UITableViewCell() }
                
                clinicsInfoCell.clinicNameLabelOutlet.text = mappedDoctorInfo?.hospitalName
                clinicsInfoCell.clinicCountryLabelOutlet.text = mappedDoctorInfo?.hospitalPhysicalAddress
                let imageURL = "https://test.liviaapp.com" + (mappedDoctorInfo?.hospitalAvatar)!
                getImage(pictureUrl: imageURL) { success, image in
                    if success {
                        clinicsInfoCell.clinicPictureImageViewOutlet.image = image
                    }
                }
                clinicsInfoCell.pharmacyLocation = CLLocationCoordinate2D(latitude: Double((mappedDoctorInfo?.hospitalLatitude)!)!, longitude: Double((mappedDoctorInfo?.hospitalLongitude)!)!)
                
                clinicsInfoCell.backgroundColor = .white
                
                return clinicsInfoCell
            case 2:
                if mappedDoctorInfo?.doctorsPhotos.count != 0 {
                    guard let doctorsPhotoCell = tableView.dequeueReusableCell(withIdentifier: "doctorPhotoCell") as? DoctorsPhotosCell else { return UITableViewCell() }
                    
                    doctorsPhotoCell.backgroundColor = .white
                    
                    return doctorsPhotoCell
                } else {
                    guard let aboutMeCell = tableView.dequeueReusableCell(withIdentifier: "aboutMeCell") as? AboutMeCell else { return UITableViewCell() }
                    
                    aboutMeCell.aboutMeLabelOutlet.text = mappedDoctorInfo?.aboutMe
                    
                    aboutMeCell.backgroundColor = .white
                    
                    return aboutMeCell
                }
            case 3:
                guard let aboutMeCell = tableView.dequeueReusableCell(withIdentifier: "aboutMeCell") as? AboutMeCell else { return UITableViewCell() }
                
                aboutMeCell.aboutMeLabelOutlet.text = mappedDoctorInfo?.aboutMe
                
                aboutMeCell.backgroundColor = .white
                
                return aboutMeCell
            default:
                break
            }
        }
        return UITableViewCell()
    }
}

extension CertainDoctorVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 68
        case 1:
            return 240
        case 2:
            if mappedDoctorInfo?.doctorsPhotos.count != 0 {
                return 120
            } else {
                return UITableViewAutomaticDimension
            }
        case 3:
            return UITableViewAutomaticDimension
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let clinicsView = UIView()
        
        let clinicsLabel = UILabel()
        
        clinicsLabel.frame = CGRect(x: 10, y: 10, width: 100, height: 25)
        switch section {
        case 0:
            let view = (Bundle.main.loadNibNamed("SpecializationsHeader", owner: self, options: nil)![0] as? SpecializationsHeaderView)
            view?.delegate = self
            var specializations = String()
            var count = 0
            if mappedDoctorInfo?.doctorsSpecializationsList.count != nil {
                if isExpanded {
                    view?.arrowLabelOutlet.text = "▼"
                    for specialization in (mappedDoctorInfo?.doctorsSpecializationsList)! {
                        if specialization.name == mappedDoctorInfo?.doctorsSpecializationsList.last?.name {
                            specializations += specialization.name!
                        } else {
                            specializations += specialization.name! + ", "
                        }
                    }
                } else {
                    view?.arrowLabelOutlet.text = "▲"
                    for specialization in (mappedDoctorInfo?.doctorsSpecializationsList)! {
                        if specialization.name == mappedDoctorInfo?.doctorsSpecializationsList[1].name {
                            specializations += specialization.name!
                        } else {
                            specializations += specialization.name! + ", "
                        }
                        count += 1
                        if count == 2 {
                            specializations += " (+" + String((mappedDoctorInfo?.doctorsSpecializationsList)!.count - count) + ")"
                            break
                        }
                    }
                    
                }
            }
            
            view?.specializationsLabelOutlet.text = specializations
            
            return view
        case 1:
            clinicsLabel.text = "CLINICS"
            
            let seeAllClinicsButton = UIButton()
            seeAllClinicsButton.frame = CGRect(x: 250, y: 10, width: 70, height: 25)
            seeAllClinicsButton.layer.cornerRadius = 5
            seeAllClinicsButton.setTitle("SEE ALL", for: .normal)
            seeAllClinicsButton.backgroundColor = Colors.Root.lightBlueColor
            seeAllClinicsButton.setTitleColor(UIColor.white, for: .normal)
            seeAllClinicsButton.addTarget(self, action: #selector(seeAllButtonTapped(_ :)), for: .touchUpInside)
            
            clinicsView.addSubview(seeAllClinicsButton)
        case 2:
            if mappedDoctorInfo?.doctorsPhotos.count != 0 {
                clinicsLabel.text = "PHOTOS"
            } else {
                clinicsLabel.text = "ABOUT ME"
            }
        case 3:
            clinicsLabel.text = "ABOUT ME"
        default:
            break
        }
        clinicsView.backgroundColor = Colors.Root.lightGrayColor
        clinicsLabel.textColor = .white
        clinicsLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        clinicsView.addSubview(clinicsLabel)
        
        return clinicsView
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 2 && mappedDoctorInfo?.doctorsPhotos.count != 0 {
            guard let doctorPhotoCell = tableView.dequeueReusableCell(withIdentifier: "doctorsPhotosCell") as? DoctorsPhotosCell else { return }
            
            doctorPhotoCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self)
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            if isExpanded {
                return 100
            }
            return 55
        default:
            return 45
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            guard let selectedCell = tableView.cellForRow(at: indexPath) as? DoctorPhoneCell else { return }
            
            if let url = URL(string: "tel://\(String(describing: selectedCell.doctorPhoneNumberLabelOutlet.text))"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            } else {
                let alertController = UIAlertController.init(title: nil, message: "Device has no phone.", preferredStyle: .alert)
                
                let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: {(alert: UIAlertAction!) in
                })
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)

            }
        default:
            break
        }
    }
}

extension CertainDoctorVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mappedDoctorInfo!.doctorsPhotos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let doctorsPhotosCell = collectionView.dequeueReusableCell(withReuseIdentifier: "doctorPhotosCell",
                                                                   for: indexPath) as! DoctorPhotoCVCell
        
        let imageURL = "https://test.liviaapp.com" + (mappedDoctorInfo?.doctorsPhotos[indexPath.row].stringValue)!
        getImage(pictureUrl: imageURL) { success, image in
            if success {
                doctorsPhotosCell.doctorPhotoImageViewOutelt.image = image
            }
        }
        
        return doctorsPhotosCell
    }
}
