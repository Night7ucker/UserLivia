//
//  DoctorListVC.swift
//  User
//
//  Created by User on 10/12/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import RealmSwift

class DoctorListVC: RootViewController, SigninViewControllerDelegate {
    @IBOutlet weak var searchTextFieldOutlet: UITextField!
    
    @IBOutlet weak var searchDoctorTextFieldOutlet: UITextField!
    
    @IBOutlet weak var doctorsTableView: UITableView!
    
    @IBOutlet weak var showOnMapViewOutlet: UIView!
    
    var specializationID: String?
    var specializationName: String?
    var offset = 0
    
    private var lastContentOffset: CGFloat = 0
    
    var footerView = UIView()
    
    var doctorsArray: Results<DoctorModel>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if RealmDataManager.getDoctorsArray().count != 0 {
            let realm = try! Realm()
            try! realm.write {
                realm.delete(RealmDataManager.getDoctorsArray())
            }
        }
        
        configureNavigationBar()
        if isUserLogged {
            addBackButtonAndTitleWithTwoLabelsToNavigationBar(title: specializationName!, bottomLabelTitle: RealmDataManager.getUserDataFromRealm()[0].cityName! + ", " + RealmDataManager.getUserDataFromRealm()[0].countryName!)
        } else {
            addBackButtonAndTitleWithTwoLabelsToNavigationBar(title: specializationName!, bottomLabelTitle: RealmDataManager.getCitiesNamesFromRealm()[0].cityName! + ", " + RealmDataManager.getCitiesNamesFromRealm()[0].countryName!)
        }
        addCityButtonToNavigationBar()
        
        doctorsTableView.delegate = self
        doctorsTableView.dataSource = self
        
        doctorsTableView.tableFooterView = UIView(frame: .zero)
        GetDoctorRequest.getDoctorList(specializationID: specializationID!, searchText: "", offset: offset) { success in
            if success {
                self.doctorsArray = RealmDataManager.getDoctorsArray()
                self.doctorsTableView.reloadData()
            }
        }
        
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showMapTapped(_ :)))
        
        showOnMapViewOutlet.addGestureRecognizer(tapGesture)
        
        searchTextFieldOutlet.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if RealmDataManager.getDoctorsArray().count != 0 {
            let realm = try! Realm()
            try! realm.write {
                realm.delete(RealmDataManager.getDoctorsArray())
            }
        }
    }
    
    @objc func showMapTapped(_ sender: UITapGestureRecognizer) {
        
    }
    
    func pushToRegistrationViewController() {
        let mainViewStoryboard = UIStoryboard(name: "MainViewsStoryboard", bundle: nil)
        let registrationViewController = mainViewStoryboard.instantiateViewController(withIdentifier: "kRegistrationViewController") as! RegistrationViewController
        navigationController?.pushViewController(registrationViewController, animated: false)
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        if RealmDataManager.getDoctorsArray().count != 0 {
            let realm = try! Realm()
            try! realm.write {
                realm.delete(RealmDataManager.getDoctorsArray())
            }
        }
        GetDoctorRequest.getDoctorList(specializationID: specializationID!, searchText: sender.text!, offset: offset) {
            success in
            if success {
                print(sender.text!)
                self.doctorsArray = RealmDataManager.getDoctorsArray()
                self.doctorsTableView.reloadData()
            }
        }
    }
}

extension DoctorListVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numberOfRows = doctorsArray?.count {
            return numberOfRows
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let doctorCell = tableView.dequeueReusableCell(withIdentifier: "doctorCell") as! DoctorCellTableViewCell
        
        doctorCell.doctorNameLabelOutlet.text = doctorsArray![indexPath.row].name
        doctorCell.doctorAddressLabelOutlet.text = doctorsArray![indexPath.row].address
        doctorCell.doctorFeeLabelOutlet.text = "Fee - " + doctorsArray![indexPath.row].consultationsFees!
        doctorCell.doctorExperienceLabelOutelt.text = "Experience - " + doctorsArray![indexPath.row].experienceYears!
        
        if indexPath.row == (doctorsArray?.count)! - 1 {
            offset += 20
            GetDoctorRequest.getDoctorList(specializationID: specializationID!, searchText: "", offset: offset) { success in
                if success {
                    self.doctorsArray = RealmDataManager.getDoctorsArray()
                    self.doctorsTableView.reloadData()
                }
            }
        }
        
        return doctorCell
    }
}

extension DoctorListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset > scrollView.contentOffset.y) {
            showOnMapViewOutlet.isHidden = false
            
        }
        else if (self.lastContentOffset < scrollView.contentOffset.y) {
            showOnMapViewOutlet.isHidden = true
        }
        
        // update the new position acquired
        self.lastContentOffset = scrollView.contentOffset.y
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isUserLogged {
            
        } else {
            let signInViewStoryboard = UIStoryboard(name: "SigninViewStoryboard", bundle: nil)
            let signInViewController = signInViewStoryboard.instantiateViewController(withIdentifier: "kSigninViewController") as! SigninViewController
            signInViewController.delegate = self
            present(signInViewController, animated: false, completion: nil)
        }
    }
}
