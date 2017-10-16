//
//  FindDoctorVC.swift
//  User
//
//  Created by User on 10/9/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import RealmSwift

class FindDoctorVC: RootViewController {
    
    @IBOutlet weak var textFieldForSearchingOutlet: UITextField!
    @IBOutlet weak var specialityTypesTableView: UITableView!
    
    var doctorsSpecializationList: Results<DoctorSpecialityModel>? = nil
    var offsetForSpecializations = 0
    var isOneScrollBottom = false
    
    var parentId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if RealmDataManager.getDoctorSpecialityList().count != 0 {
            let realm = try! Realm()
            try! realm.write {
                realm.delete(RealmDataManager.getDoctorSpecialityList())
            }
        }

        
        textFieldForSearchingOutlet.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        specialityTypesTableView.tableFooterView = UIView(frame: .zero)
        
        //        addBackButtonAndTitleWithTwoLabelsToNavigationBar(title: "Specializations", bottomLabelTitle: "Minsk, Belarus")
        addCityButtonToNavigationBar()
        
        specialityTypesTableView.delegate = self
        specialityTypesTableView.dataSource = self
        
        specialityTypesTableView.bounces = false
        FindDoctorSpecialityRequest.getSpecialityList(parentID: parentId) { success in
            if success {
                self.doctorsSpecializationList = RealmDataManager.getDoctorSpecialityList()
                self.specialityTypesTableView.reloadData()
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        if isUserLogged {
            addBackButtonAndTitleWithTwoLabelsToNavigationBar(title: "Specializations", bottomLabelTitle: RealmDataManager.getUserDataFromRealm()[0].cityName! + ", " + RealmDataManager.getUserDataFromRealm()[0].countryName!)
        } else {
            addBackButtonAndTitleWithTwoLabelsToNavigationBar(title: "Specializations", bottomLabelTitle: RealmDataManager.getCitiesNamesFromRealm()[0].cityName! + ", " + RealmDataManager.getCitiesNamesFromRealm()[0].countryName!)
        }
    }
    
    
    override func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
        
    }

    @objc func textFieldDidChange(_ sender: UITextField) {
        if RealmDataManager.getDoctorSpecialityList().count != 0 {
            let realm = try! Realm()
            try! realm.write {
                realm.delete(RealmDataManager.getDoctorSpecialityList())
            }
        }
        FindDoctorSpecialityRequest.getSpecialityList(parentID: parentId, searchText: sender.text!) {
            success in
            if success {
                self.doctorsSpecializationList = RealmDataManager.getDoctorSpecialityList()
                self.specialityTypesTableView.reloadData()
            }
        }
        
    }
}

extension FindDoctorVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RealmDataManager.getDoctorSpecialityList().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let specializationCell = tableView.dequeueReusableCell(withIdentifier: "findDoctorCell") as! FindDoctorCellTableViewCell
        
        specializationCell.specializationNameLabelOutlet.text = doctorsSpecializationList?[indexPath.row].name
        specializationCell.imageViewOutlet.image = #imageLiteral(resourceName: "pharmacySign")
        specializationCell.specializationID = doctorsSpecializationList?[indexPath.row].id
        specializationCell.specializationName = doctorsSpecializationList?[indexPath.row].name
        specializationCell.children = doctorsSpecializationList?[indexPath.row].children
        
        if indexPath.row == (doctorsSpecializationList?.count)! - 1 {
            offsetForSpecializations += 20
            FindDoctorSpecialityRequest.getSpecialityList(parentID: parentId, offset: offsetForSpecializations) { success in
                if success {
                    self.doctorsSpecializationList = RealmDataManager.getDoctorSpecialityList()
                    self.specialityTypesTableView.reloadData()
                }
            }
        }
        
        return specializationCell
    }
}

extension FindDoctorVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as! FindDoctorCellTableViewCell
        if selectedCell.children != "0" {
            if RealmDataManager.getDoctorSpecialityList().count != 0 {
                let realm = try! Realm()
                try! realm.write {
                    realm.delete(RealmDataManager.getDoctorSpecialityList())
                }
                let findDoctorStoryboard = UIStoryboard(name: "FindDoctor", bundle: nil)
                let findDoctorViewController = findDoctorStoryboard.instantiateViewController(withIdentifier: "kFindDoctorVC") as! FindDoctorVC
                findDoctorViewController.parentId = selectedCell.specializationID!
                navigationController?.pushViewController(findDoctorViewController, animated: false)
            }
        } else {
            let findDoctorStoryboard = UIStoryboard(name: "FindDoctor", bundle: nil)
            let doctorListViewController = findDoctorStoryboard.instantiateViewController(withIdentifier: "kDoctorListVC") as! DoctorListVC
            doctorListViewController.specializationID = selectedCell.specializationID
            doctorListViewController.specializationName = selectedCell.specializationName
            
            navigationController?.pushViewController(doctorListViewController, animated: false)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var isOneScrollBottom = true
        
        let reloadTableActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        
        reloadTableActivityIndicator.color = .gray
        reloadTableActivityIndicator.center = view.center
        
        let  height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height && isOneScrollBottom {
            isOneScrollBottom = false
            reloadTableActivityIndicator.startAnimating()
            view.addSubview(reloadTableActivityIndicator)
            offsetForSpecializations += 20
            FindDoctorSpecialityRequest.getSpecialityList(parentID: parentId, offset: offsetForSpecializations) { success in
                if success {
                    self.doctorsSpecializationList = RealmDataManager.getDoctorSpecialityList()
                    self.specialityTypesTableView.reloadData()
                    isOneScrollBottom = true
                    reloadTableActivityIndicator.stopAnimating()
                }
            }
        }
    }
}
